import sys

def platform_for_uname(uname):
    m = {
        'x86_64':'linux/amd64',
        'aarch64':'linux/arm64',
        'armv7l':'linux/arm',
        's390x':'linux/s390x',
        'ppc64le':'linux/ppc64le'
    }

    if uname not in m:
        print('unsupported')
    else:
        print(m[uname])
    # end if
# end def

def main():
    if sys.argv[1] == 'platform_for_uname':
        platform_for_uname(sys.argv[2])
    # end if
# end def

if __name__ == '__main__':
    sys.exit(main())

sys.exit(0)
