#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_stable_node() {

    execute \
        "source ~/.bashrc && nvm install v6.9.5" \
        "node 6.9.5"
}

install_nvm() {

    # Install `nvm` and add the necessary
    # configs in the local shell config file.
    execute \
        "curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash" \
        "nvm"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   nvm\n\n"

    install_nvm
    install_stable_node

}

main
