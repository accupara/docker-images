#!/bin/bash

main() {
    sudo service supervisor start

    mkdir -p /home/admin/.bash_completion.d
    register-python-argcomplete crave > /home/admin/.bash_completion.d/crave
    sudo chown -R admin:admin /home/admin/.bash_completion.d
}

main $*
