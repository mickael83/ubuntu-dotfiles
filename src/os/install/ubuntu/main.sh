#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_misc_tools() {

    # Install tools for compiling/building software from source.

    install_package "Build Essential" "build-essential"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # GnuPG archive keys of the Debian archive.

    install_package "GnuPG archive keys" "debian-archive-keyring"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons.

    #install_package "Ubuntu Restricted Extras" "ubuntu-restricted-extras"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Telnet" "telnet"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "APT Transport HTTPS" "apt-transport-https"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "CA certificates" "ca-certificates"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "cURL" "curl"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Git" "git"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Git flow" "git-flow"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "VIM" "vim"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_web_servers() {
    install_package "NGINX" "nginx"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_databases() {
    # install_package "MySQL" "mysql"
    # install_package "MongoDB" "mongodb"
}

main() {

    print_in_purple "   Miscellaneous\n\n"
    update
    #upgrade
    printf "\n"
    install_misc_tools
    printf "\n"

    print_in_purple "   Web servers\n\n"
    printf "\n"
    install_web_servers
    printf "\n"

    print_in_purple "   Databases\n\n"
    printf "\n"
    install_databases
    printf "\n"


    autoremove

}

main
