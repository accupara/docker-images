# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved

# This variable controls the number of compilation processes
# within one package ("intra-package parallelism").
# Set to higher value if you have a powerful machine.
JOBS := 4

# This variable controls the targets that will build.
MXE_TARGETS :=  i686-w64-mingw32.shared

# Uncomment the next line if you want to do debug builds later
# qtbase_CONFIGURE_OPTS=-debug-and-release
