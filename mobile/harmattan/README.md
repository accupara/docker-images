# Run the docker command in the directory that has your source code
```
docker \
    run --rm -it \
    --privileged \
    -v `pwd`:/scratchbox/users/admin/home/admin/code \
    accupara/harmattan \
    /bin/bash
```

# Helpful aliases
## Start Scratchbox:
```
sb-start
```

## Switch the target using one of the two aliases:
```
sb-switch-x86   # Switch to HARMATTAN_X86
sb-switch-armel # Switch to HARMATTAN_ARMEL
```
