#!/usr/bin/python3
# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

import os
import sys
import argparse
import json
import datetime
import requests
import inspect
import pick
import subprocess


def printf(format, *args):
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
    sys.stdout.write(format % args)
# end def


def is_valid_dir(arg):
    # Path must exist
    if not os.path.exists(arg):
        raise argparse.ArgumentError('Invalid path')
    # end if

    # Argument must be a directory
    arg = os.path.abspath(arg)
    if not os.path.isdir(arg):
        printf('Invalid argument: %s is not a directory\n', arg)
        raise argparse.ArgumentError(
            'Invalid argument: %s is not a directory' % arg)
    # end if

    return arg
# end def


def parse_argv():
    parser = argparse.ArgumentParser(
        description='An easy way to use Accupara build environments')

    parser.add_argument('-C', '--changeDir', default=os.getcwd(), type=is_valid_dir,
                        help='Change to directory before doing anything else')
    parser.add_argument('--cmds', nargs='+', help='Commands to run')

    return parser.parse_args()
# end def


def get_images():
    try:
        r = requests.get(
            'https://raw.githubusercontent.com/accupara/docker-images/master/useme/image_list.json')
        return json.loads(r.text)
    except Exception as e:
        printf("Failed to retrieve images. Error: %s\n", repr(e))
# end def


def ensure_valid_config_file(args):
    config = {}

    cfgFile = os.path.join(args.changeDir, 'pup.cfg')
    if os.path.exists(cfgFile):
        try:
            fp = open(cfgFile, 'r')
            config = json.load(fp)
            fp.close()
        except Exception as e:
            printf('Failed to load configuration from file %s: %s\n',
                   cfgFile, repr(e))
            if fp:
                fp.close()
            # end if
            return None
        # end try
    # end if

    # Start filling the fields that aren't already present
    config['cfgFile'] = cfgFile

    if 'imageUrl' not in config:
        images = get_images()['images']
        options = []
        for image in images:
            options.append(image['summary'])
        # end for

        option = pick.pick(options, 'Enter the URL for the build image: ')
        print(option)
        config['imageUrl'] = images[option[1]]['imageUrl']
    # end if

    if 'mountPath' not in config:
        config['mountPath'] = '/tmp/src'
    # end if

    if 'cmds' not in config:
        config['cmds'] = []
        if args.cmds:
            for cmd in args.cmds:
                config['cmds'].append(cmd.split())
        else:
            cmd = input('Enter command to run: ')
            config['cmds'] = [ cmd.split() ]
        # end if
    # end if

    return config
# end def


def serialize_config(config):
    cfgFile = config['cfgFile']
    del(config['cfgFile'])
    config = json.dumps(config, indent=2)
    fp = open(cfgFile, 'w+')
    fp.write(config)
    fp.close()
# end def


def main():
    args = parse_argv()

    #images = get_images()
    # print(images)

    printf('Changing current directory to %s\n', args.changeDir)
    os.chdir(args.changeDir)

    # Check for existance of config file
    config = ensure_valid_config_file(args)
    if not config:
        printf('Failed to ensure a valid configuration\n')
        return 1
    # end if

    # Pull out the commands and run each one
    for cmd in config['cmds']:
        cmd = ('cd %s ; ' % config['mountPath']) + ' '.join(cmd)
        dcmd = ['docker', 'run', '--rm', '-it',
            '-v', '%s:%s' % (args.changeDir, config['mountPath']),
            config['imageUrl'],
            '/bin/bash', '-c', cmd,
            ]
        printf('Run command: %s\n', dcmd)
        subprocess.Popen(dcmd).communicate()

    # Serialize it into the config file
    serialize_config(config)

    return 0
# end main


if __name__ == '__main__':
    sys.exit(main())

sys.exit(0)
