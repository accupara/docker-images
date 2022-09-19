#!/bin/bash

set -x

sudo service supervisor start
exec $*
