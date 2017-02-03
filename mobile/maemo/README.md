# Run the docker command in the directory that has your source code
```
docker \
    run --rm -it \
    --privileged \
    -v `pwd`:/scratchbox/users/admin/home/admin/src \
    accupara/maemo \
    /bin/bash
```
The path to the user home directory inside scratchbox is `/scratchbox/users/admin/home/admin`

# Helpful aliases
## Start Scratchbox:
```
sb-start
```

## Switch the target using one of the two aliases:
```
sb-switch-x86   # Switch to FREMANTEL_X86
sb-switch-armel # Switch to FREMANTEL_ARMEL
```

##  Login to scratchbox
```
/scratchbox/login
```

## Run a command inside scratchbox
```
/scratchbox/login make -C ~/src build
```
