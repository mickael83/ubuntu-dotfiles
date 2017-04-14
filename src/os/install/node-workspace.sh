#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_stable_node() {

    execute \
        "source ~/.bashrc && nvm install v6.9.5" \
        "node 6.9.5"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_nvm() {

    # Install `nvm` and add the necessary
    # configs in the local shell config file.
    execute \
        "curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash" \
        "nvm"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_npm_package() {
    execute \
        "source ~/.bashrc && npm install --global --silent $2" \
        "$1"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


main() {

    print_in_purple "\n   Node workspace\n\n"

    install_nvm
    install_stable_node
    install_npm_package "npm (update)" "npm"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    printf "\n"
    install_npm_package "cordova" "cordova"
    install_npm_package "ionic" "ionic"
    install_npm_package "gulp" "gulp"
    install_npm_package "bower" "bower"
    install_npm_package "yo" "yo"
    install_npm_package "typescript" "typescript"
    install_npm_package "tslint" "tslint"
    install_npm_package "csslint" "csslint"
    install_npm_package "node-sass" "node-sass"
    install_npm_package "scss-lint" "scss-lint"
    install_npm_package "phplint" "phplint"
    install_npm_package "jshint" "jshint"
    install_npm_package "jscs" "jscs"
    install_npm_package "json-server" "json-server"
    install_npm_package "http-server" "http-server"
    install_npm_package "generator-angular2-library" "generator-angular2-library"
    install_npm_package "@angular/cli@latest" "@angular/cli@latest"
}

main
