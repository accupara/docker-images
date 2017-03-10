#!/usr/bin/python3
# Copyright (c) 2017 Accupara Inc. All rights reserved

import sys
import argparse
import json
import datetime

def parse_argv():
    parser = argparse.ArgumentParser(description='An easier way to use Accupara build environments')

    return parser.parse_args()
# end def


def main():
    args = parse_argv()

    return 0
# end main


if __name__ == '__main__':
    sys.exit(main())

sys.exit(0)
