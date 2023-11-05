#!/usr/bin/python3
# Copyright (c) 2017-2023 Crave Crave.io Inc. All rights reserved

import os
import sys
import argparse
import json
import time
import datetime
import dateutil.parser
import tzlocal
import requests
import inspect
import pick
import glob
import subprocess

import concurrent.futures as cf

externalMtimes = {}


def printf(str):
    f = inspect.currentframe()
    if f:
        f = f.f_back
        c = f.f_code
        bname = os.path.basename(c.co_filename)
        f = '%s: %s(%d): ' % (datetime.datetime.now().isoformat(),
                              bname, f.f_lineno)
    else:
        f = "%s: " % datetime.datetime.now().isoformat()
    # end if

    sys.stdout.write(f)
    sys.stdout.write(str)
# end def


def is_valid_dir(arg):
    # Path must exist
    if not os.path.exists(arg):
        raise argparse.ArgumentError('Invalid path')
    # end if

    # Argument must be a directory
    arg = os.path.abspath(arg)
    if not os.path.isdir(arg):
        printf('Invalid argument: {} is not a directory\n'.format(arg))
        raise argparse.ArgumentError(
            'Invalid argument: %s is not a directory' % arg)
    # end if

    return arg
# end def


def parse_argv():
    parser = argparse.ArgumentParser(
        description='Build all docker images')

    parser.add_argument('-C', '--changeDir', default=os.getcwd(), type=is_valid_dir,
                        help='Change to directory before doing anything else')
    parser.add_argument('-n', '--dry-run', default=False, action='store_true', dest='dryRun',
                        help='Dry run, dont execute the actual build commands')
    parser.add_argument('-j', '--threads', default=2, type=int,
                        help='Number of threads to employ')
    parser.add_argument('--only-with-base', default=False, dest='only_with_base', action='store_true',
                        help='Compile only when there is an IMGVER_BASE variable')

    return parser.parse_args()
# end def


def getAllIgnoredDirs(args):
    # Let's find all the .ignoreDir files
    ignoreDirFiles = glob.glob(os.path.join(
        args.changeDir, '**/.ignoreDir'), recursive=True)
    ignoreDirs = []
    for i in ignoreDirFiles:
        ignoreDirs.append(os.path.dirname(i))
    return ignoreDirs

def getAllDockerFiles(args):
    ignoreDirs = getAllIgnoredDirs(args)
    # Let's find every Dockerfile in this path and all subpaths
    allRelPaths = glob.glob(os.path.join(
        args.changeDir, '**/Dockerfile'), recursive=True)
    fullPaths = []
    for relPath in allRelPaths:
        fullPath = os.path.abspath(relPath)

        # Ignore the directories that have the ".ignoreDir" sentinel file
        ignoreThisOne = False
        for i in ignoreDirs:
            if i in fullPath:
                ignoreThisOne = True
                break
        # end for
        if ignoreThisOne:
            continue
        # end if

        # If we're supposed to only build arch specific images, then check if this Makefile has the IMAGE_BASE
        if args.only_with_base == True:
            cmd = [ 'make', '-C', os.path.dirname(fullPath), '--no-print-directory', 'is_arch_specific' ]
            p = subprocess.run(cmd, text=True, stdin=None, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            if p.stdout.strip().lower() != "yes":
                continue
            # end if
        # end if

        fullPaths.append(fullPath)
    # end for

    return fullPaths
# end def


def getImageFrom(dockerFile):
    rv = None
    with open(dockerFile, 'r') as f:
        # Read line by line and look for the FROM line
        for line in f:
            if 'FROM' in line:
                line = line.rstrip().replace('FROM', '').lstrip().lower()
                try:
                    asIndex = line.index('as')
                    rv = line[asIndex-1]
                except:
                    rv = line
                # end try
            # end if
        # end for
    # end with
    return rv
# end def


def getImageDest(makefile):
    cmd = ['make', '--no-print-directory', '-C', os.path.dirname(makefile), 'get_image_name']
    name_list = subprocess.run(cmd, text=True, stdin=None, stdout=subprocess.PIPE, stderr=subprocess.PIPE).stdout.strip().splitlines()
    #printf('cmd = {}. name_list = {}\n'.format(cmd, name_list))
    rv = []
    for entry in name_list:
        #printf('entry = {}\n'.format(entry))
        if 'ing directory' in entry:
            # ignore Entering and Leaving directory messages
            continue
        # end if
        platform, name = entry.split()
        rv.append([platform, name])
    # end for
    return rv
# end def


class ImageNode:
    def __init__(self, Dockerfile='', Makefile='', parentName='', imageName='', platform='default'):
        self.Dockerfile = Dockerfile
        self.Makefile = Makefile
        self.parentName = parentName
        self.imageName = imageName
        self.parentImage = None
        self.dependentImageList = []
        # Impossibly old date
        self.mtime = datetime.datetime(1970, 1, 1, tzinfo=datetime.timezone.utc)
        # Markers
        self.isStale = False
        self.buildInProgress = False
        self.platform = platform
    # end def

    def __str__(self):
        return str({'Dockerfile': self.Dockerfile, 'Makefile': self.Makefile, 'base': self.parentName, 'name': self.imageName, 'platform': self.platform})
# end class


def parseAllDockerFiles(allDockerfiles):
    imageList = []
    for filePath in allDockerfiles:
        fromLine = getImageFrom(filePath)
        if not fromLine:
            continue
        # end if

        makefile = os.path.join(os.path.dirname(filePath), 'Makefile')
        if not os.path.exists(makefile):
            continue
        # end if

        images = getImageDest(makefile)
        for image in images:
            #printf('image = {}\n'.format(image))
            if fromLine == image[1]:
                printf('Recursive image: from = {}. to = {}\n'.format(fromLine, image[1]))
                continue
            # end if

            entry = ImageNode(Dockerfile=filePath, Makefile=makefile, parentName=fromLine, imageName=image[1], platform=image[0])
            imageList.append(entry)
        # end for
    # end for

    return imageList
# end def


def printDepList(image):
    msg = '"%s": [' % image.imageName
    first = True
    for i in image.dependentImageList:
        if first:
            msg += '"%s"' % i.imageName
            first = False
        else:
            msg += ', "%s"' % i.imageName
        # end if
    # end for
    msg += ']'
    print(msg)
# end def


def generateImageLinks(imageList):
    # Connect every image to its parent
    for lhs in imageList:
        for rhs in imageList:
            if lhs.imageName == rhs.imageName:
                continue
            # end if

            if lhs.imageName == rhs.parentName:
                # printf('{} derived from {} :: {}\n'.format(rhs.imageName,
                # lhs.imageName, rhs.Dockerfile))

                if rhs.parentImage:
                    printf('**** Changing {} parent from {} to {}'.format(
                           rhs.imageName, rhs.parentImage.imageName, lhs.imageName))
                # end if

                rhs.parentImage = lhs

                if rhs not in lhs.dependentImageList:
                    lhs.dependentImageList.append(rhs)
                # end if
            # end if
        # end for
    # end for
# end def


def getImageMtime(imageName):
    #printf('imageName = {}'.format(imageName))

    ctrAuthPath = '/opt/config.json'
    hostAuthPath = os.path.expanduser(os.path.join('~', '.docker', 'config.json'))
    authParam = '{}:{}'.format(hostAuthPath, ctrAuthPath)

    cmd = ['docker', 'run', '--rm', '-i']

    if os.path.exists(hostAuthPath):
        cmd.extend(['-v', authParam])
    else:
        printf('Authparam {} not found!\n'.format(authParam))
    # end if

    cmd.extend(['quay.io/skopeo/stable:latest', 'inspect'])
    
    if os.path.exists(hostAuthPath):
        cmd.extend(['--authfile', ctrAuthPath])
    # end if
    cmd.append('docker://%s' % imageName)
    #printf('cmd: {}\n'.format(cmd))

    mtime = None
    try:
        p = subprocess.run(cmd, text=True, stdin=None, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        data = json.loads(p.stdout)
        mtime = dateutil.parser.parse(data['Created'])
        #printf('mtime {} for {}\n'.format(mtime, imageName))
    except Exception as err:
        printf('Exception retrieving mtime for {}\n'.format(imageName))
        printf('o:{}\ne:{}\nerr:{}\n'.format(p.stdout, p.stderr, err))
    # end try

    # print('mtime for %s: %s' % (imageName, mtime))
    return mtime
# end def


def updateImageMtime(image):
    mtime = getImageMtime(image.imageName)
    #printf('Updating mtime for {} to {}\n'.format(image, mtime))
    if mtime:
        image.mtime = mtime
    # end if
# end def


def getExternalImageMtime(imageName):
    if imageName not in externalMtimes:
        externalMtimes[imageName] = getImageMtime(imageName)
    # end if

    return externalMtimes[imageName]
# end def


def updateImageMtimes(imageList):
    printf('Fetching image mtimes\n')
    allFutures = []

    with cf.ThreadPoolExecutor(max_workers=10) as executor:
        for i in imageList:
            #printf('image: {}\n'.format(i))
            allFutures.append(executor.submit(updateImageMtime, i))
        # end for

        for i in imageList:
            if not i.parentImage:
                #printf('parent image: {}\n'.format(i.parentName))
                allFutures.append(executor.submit(getExternalImageMtime, i.parentName))
            # end if
        # end for
    # end with

    #printf('af count: {}\n'.format(len(allFutures)))
    cf.wait(allFutures)
    #printf('all afs done\n')
# end def


def updateDockerfileMtimes(imageList):
    tz = tzlocal.get_localzone()

    printf('Updating Dockerfile mtimes\n')
    for i in imageList:
        try:
            # Run 'git status --porcelain Dockerfile' and see if it starts off with an 'M'
            localModification = False
            cmd = ['git', 'status', '--porcelain', i.Dockerfile]
            for line in subprocess.run(cmd, capture_output=True).stdout.decode().splitlines():
                line = line.strip()
                if line.startswith('M'):
                    localModification = True
                # end if
            # end for
            
            mtime = None
            if localModification:
                epochSec = os.path.getmtime(i.Dockerfile)
                mtime = datetime.datetime.fromtimestamp(epochSec, tz)
                #printf('Image mtime = {}. Dockerfile mtime = {}\n'.format(str(i.mtime), str(mtime)))
            else:
                # No local modifications, look for the committed time on the file to get accurate mtime
                cmd = ['git', 'log', '-1', '--pretty="%cI"', i.Dockerfile]
                line = subprocess.run(cmd, capture_output=True).stdout.decode().replace('"', '').strip()
                #printf("output of {}: '{}'\n".format(cmd, line))
                mtime = datetime.datetime.fromisoformat(line)
            # end if

            #printf('{} is < {}\n'.format(i.mtime, mtime))
            if i.mtime < mtime:
                recursivelyMarkStale(i)
            # end if
        except Exception as e:
            printf('Failed to retrieve mtime for {}: {}\n'.format(i.Makefile, e))
        # end try
    # end for
# end def


def recursivelyMarkStale(image):
    for i in image.dependentImageList:
        recursivelyMarkStale(i)
    # end for
    image.isStale = True
# end def


def markImagesOlderThanParent(imageList):
    for i in imageList:
        if i.isStale:
            continue
        # end if

        if i.parentImage:
            if i.parentImage.mtime > i.mtime:
                recursivelyMarkStale(i)
            # end if
        else:
            mtime = getExternalImageMtime(i.parentName)
            if not mtime or mtime > i.mtime:
                recursivelyMarkStale(i)
            # end if
        # end if
    # end for
# end def


def printImages1(imageList):
    for image in imageList:
        msg = '%s' % image.imageName
        while True:
            if not image.parentImage:
                msg += ' <- [%s]' % image.parentName
                break
            # end if

            image = image.parentImage
            msg += ' <- %s' % image.imageName
        # end while

        print(msg)
    # end for
# end def


def printImages2(imageList):
    print('{')

    outerFirst = True
    for image in imageList:
        if outerFirst:
            outerFirst = False
        else:
            print(',\n')
        # end if
        printDepList(image)
    # end for

    print('}')
# end def


def printImages3(imageList):
    for i in imageList:
        if i.isStale:
            print('%s is stale' % i.imageName)
        else:
            print('%s is NOT stale' % i.imageName)
        # end if
    # end for
# end def


def createBuildPlan(imageList):
    printf('Generating build plan...\n')

    plan = []

    for i in imageList:
        if not i.isStale:
            continue
        # end if

        imagePlan = [i]
        while i.parentImage and i.parentImage.isStale:
            imagePlan.append(i.parentImage)
            i = i.parentImage
        # end while

        plan.append(list(reversed(imagePlan)))
    # end for

    return plan
# end def


def printBuildPlan(plan):
    print('Build plan:')
    for imagePlan in plan:
        first = True
        msg = ''
        for i in imagePlan:
            if first:
                first = False
                msg += '%s' % i.imageName
            else:
                msg += ' -> %s' % i.imageName
            # end if
        # end for
        print(msg)
    # end for
# end def


def rebuildImage(args, image):
    cmd = ['make', '-C', os.path.dirname(image.Makefile)]
    if image.platform != 'default':
        cmd.extend(['build_{}'.format(image.platform), 'push_{}'.format(image.platform)])
    else:
        cmd.extend(['build', 'push'])
    # end if
    cmd.append('NOCACHE=yes')
    if args.dryRun:
        printf('{}\n'.format(cmd))
        #time.sleep(1)
        pass
    else:
        # Then start a rebuild in the correct directory
        rv = subprocess.call(cmd)
        if rv != 0:
            return rv
        # end if
    # end if

    image.isStale = False
    image.buildInProgress = False

    if args.dryRun == False:
        printf('{} is ready\n'.format(image.imageName))
    # end if

    return 0
# end def


def onePassOverBuildPlan(args, plan, executor):
    submitted = []

    i = 0
    while i < len(plan):
        j = 0
        while j < len(plan[i]):
            if plan[i][j].isStale == False:
                del(plan[i][j])
                continue
            # end if

            if plan[i][j].buildInProgress == True:
                # printf('{} is building. Come again later\n'.format(plan[i][j].imageName))
                break
            # end if

            printf('Build: {}\n'.format(plan[i][j].imageName))

            plan[i][j].buildInProgress = True
            submitted.append(executor.submit(rebuildImage, args, plan[i][j]))

            break
        # end while

        if len(plan[i]) == 0:
            del(plan[i])
            continue
        # end if

        i = i + 1
    # end while

    return submitted
# end def


def execBuildPlan(args, plan):
    submitted = []
    with cf.ThreadPoolExecutor(max_workers=args.threads) as executor:
        while len(plan) != 0:
            submitted.extend(onePassOverBuildPlan(args, plan, executor))

            fs = cf.as_completed(submitted)
            for f in fs:
                if f.result() != 0:
                    printf('Some docker build failed!\n')
                    return 1
                # end if

                submitted.remove(f)
            # end for
        # end while
    # end with

    return 0
# end def


def main():
    args = parse_argv()

    allDockerfiles = getAllDockerFiles(args)
    # printf('All Dockerfiles:\n{}\n'.format(json.dumps(allDockerfiles, indent=2)))

    imageList = parseAllDockerFiles(allDockerfiles)
    # printf('image[0] = {}\n'.format(str(imageList[0])))

    generateImageLinks(imageList)

    updateImageMtimes(imageList)
    updateDockerfileMtimes(imageList)

    markImagesOlderThanParent(imageList)

    # printImages1(imageList)
    # printImages2(imageList)
    # printImages3(imageList)

    buildPlan = createBuildPlan(imageList)

    # printBuildPlan(buildPlan)

    execBuildPlan(args, buildPlan)

    #subprocess.run(['reset'])
    return 0
# end main


if __name__ == '__main__':
    sys.exit(main())

sys.exit(0)
