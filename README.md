# Docker images for various compilation contexts

## Why?
Getting just the right dependencies to compile a project is a chore.   
Why can't it just be available without the libraries stepping on each other and polluting your pristine development environment?   
A Docker container can contain the entire build environment into an easy to use package that will not pollute your dev box.  
Besides, you could even have multiple build environments without any environment interfering with the other.   
It is like a Python virtualenv that works even for non-Python projects!   
![alt text][pacha_justright]

[pacha_justright]: https://i.imgflip.com/1ecipw.jpg

When building on the Accupara infrastructure, these docker images are a good starting point for containing the dependencies required for compiling your projects.

- All containers are based off non-root Ubuntu images
- I've tried to keep the obvious similarities higher up in the image layer stack

## List of build environments
- Linux kernel compilation: [Dockerfile](https://github.com/accupara/docker-images/blob/master/linuxkernel/Dockerfile), and [image](https://hub.docker.com/r/accupara/lkbuild/)
- Android apps: [Dockerfile](https://github.com/accupara/docker-images/blob/master/mobile/android/Dockerfile), and [image](https://hub.docker.com/r/accupara/android/)
- BlackBerry 10 apps: [Makefile](https://github.com/accupara/docker-images/blob/master/mobile/bb10/ndk/Makefile), and [image](https://hub.docker.com/r/accupara/bbndk/)
- Qt apps targeting Linux: [Top level](https://github.com/accupara/docker-images/tree/master/qt), and images: [qt4](https://hub.docker.com/r/accupara/qt4/), [qt5](https://hub.docker.com/r/accupara/qt5/), etc.
- qemu: [Dockerfile](https://github.com/accupara/docker-images/blob/master/qemu/Dockerfile), and [image](https://hub.docker.com/r/accupara/qemu/)
- rsync: [Dockerfile](https://github.com/accupara/docker-images/blob/master/rsync/Dockerfile), and [image](https://hub.docker.com/r/accupara/rsync/)
- gcc [Dockerfile](https://github.com/accupara/docker-images/blob/master/gcc/Dockerfile), and [image](https://hub.docker.com/r/accupara/gcc/)
