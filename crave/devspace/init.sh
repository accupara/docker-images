#!/bin/bash

main() {
    #sudo service supervisor start

    mkdir -p /home/admin/.bash_completion.d
    register-python-argcomplete crave > /home/admin/.bash_completion.d/crave
    sudo chown -R admin:admin /home/admin/.bash_completion.d
    if [ ! -f /home/admin/.bash_completion ]; then
        cat <<EOF > /home/admin/.bash_completion
for bcfile in ~/.bash_completion.d/* ; do
    [ -f "\$bcfile" ] && . \$bcfile
done
EOF
    fi
}

main $*
