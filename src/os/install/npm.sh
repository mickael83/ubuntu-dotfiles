#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_npm_package() {

    execute \
        ". $HOME/.bash.local \
            && npm install --global --silent $2" \
        "$1"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   npm\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_npm_package "npm (update)" "npm"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    printf "\n"

    install_npm_package "JSHint" "jshint"
    #install_npm_package "JSLint" "jslint"
    install_npm_package "CSSLint" "csslint"
    install_npm_package "TSLint" "tslint"
    install_npm_package "PHPLint" "phplint"

    install_npm_package "Gulp" "gulp"
    install_npm_package "Bower" "bower"

    #install_npm_package "Ionic" "ionic"
    #install_npm_package "Cordova" "cordova"



}

main
