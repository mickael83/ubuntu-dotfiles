#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_apps() {

    # Install tools for compiling/building software from source.

    install_package "Build Essential" "build-essential"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # GnuPG archive keys of the Debian archive.

    install_package "GnuPG archive keys" "debian-archive-keyring"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons.

    #install_package "Ubuntu Restricted Extras" "ubuntu-restricted-extras"

    printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Brotli" "brotli"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "APT Transport HTTPS" "apt-transport-https"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "CA certificates" "ca-certificates"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "google-chrome-stable"; then

        add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
            || print_error "Chrome Canary (add key)"

        add_to_source_list "[arch=amd64] https://dl.google.com/linux/deb/ stable main" "google-chrome.list" \
            || print_error "Chrome Canary (add to package resource list)"

        update &> /dev/null \
            || print_error "Chrome Canary (resync package index files)"

    fi

    install_package "Google Chrome" "google-chrome-stable"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "spotify-client"; then

        add_key_by_param "keyserver.ubuntu.com" "D2C19886"  \
            || print_error "Spotify (add key)"

        add_to_source_list "deb http://repository.spotify.com stable non-free" "spotify.list" \
            || print_error "Spotify (add to package resource list)"

        update &> /dev/null \
            || print_error "Spotify (resync package index files)"

    fi

    install_package "Spotify" "spotify-client"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "sky"; then

        add_key_by_param "keyserver.ubuntu.com" "9454C19A66B920C83DDF696E07C8CCAFCE49F8C5"  \
            || print_error "Sky (add key)"

        add_to_source_list "deb https://tel.red/repos/ubuntu yakkety non-free" "telred.list" \
            || print_error "Sky (add to package resource list)"

        update &> /dev/null \
            || print_error "Sky (resync package index files)"

    fi

    install_package "Sky (Skype for business)" "sky"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "insync"; then

        add_key_by_param "keyserver.ubuntu.com" "ACCAF35C"  \
            || print_error "InSync for Google Drive (add key)"

        add_to_source_list "deb http://apt.insynchq.com/ubuntu yakkety non-free contrib" "insync.list" \
            || print_error "InSync for Google Drive (add to package resource list)"

        update &> /dev/null \
            || print_error "InSync for Google Drive (resync package index files)"

    fi

    install_package "InSync for Google Drive" "insync"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "skypeforlinux"; then

        add_key "https://repo.skype.com/data/SKYPE-GPG-KEY" \
            || print_error "Skype for linux (add key)"

        add_to_source_list "deb [arch=amd64] https://repo.skype.com/deb stable main" "skypeforlinux.list" \
            || print_error "Skype for linux (add to package resource list)"

        update &> /dev/null \
            || print_error "Skype for linux (resync package index files)"

    fi

    install_package "Skype for linux" "skypeforlinux"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "code"; then

        add_key "https://tagplus5.github.io/vscode-ppa/ubuntu/gpg.key" \
            || print_error "Visual Studio Code (add key)"

        add_to_source_list "deb https://tagplus5.github.io/vscode-ppa/ubuntu ./" "vscode.list" \
            || print_error "Visual Studio Code (add to package resource list)"

        update &> /dev/null \
            || print_error "Visual Studio Code (resync package index files)"

    fi

    install_package "Visual Studio Code" "code"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_from_remote_deb "Apache Directory Studio" "http://mirrors.fe.up.pt/pub/apache//directory/apacheds/dist/2.0.0-M23/apacheds-2.0.0-M23-amd64.deb"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_from_remote_deb "Facebook Messenger" "https://github.com/Aluxian/Facebook-Messenger-Desktop/releases/download/v1.4.3/Messenger_linux64.deb"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_from_remote_deb "Google Music Player" "https://github.com/MarshallOfSound/Google-Play-Music-Desktop-Player-UNOFFICIAL-/releases/download/v4.0.5/google-play-music-desktop-player_4.0.5_amd64.deb"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "cURL" "curl"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Flash" "flashplugin-installer"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "GIMP" "gimp"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Git" "git"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Git flow" "git-flow"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "ImageMagick" "imagemagick"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "GParted" "gparted"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "ShellCheck" "shellcheck"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "tmux" "tmux"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Transmission" "transmission"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "VLC" "vlc"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "xclip" "xclip"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "yarn"; then

        add_key "https://dl.yarnpkg.com/debian/pubkey.gpg" \
            || print_error "Yarn (add key)"

        add_to_source_list "https://dl.yarnpkg.com/debian/ stable main" "yarn.list" \
            || print_error "Yarn (add to package resource list)"

        update &> /dev/null \
            || print_error "Yarn (resync package index files)"

    fi

    install_package "Yarn" "yarn"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! package_is_installed "virtualbox"; then

        add_key "http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc" \
            || print_error "Virtual box (add key)"

        add_to_source_list "deb http://download.virtualbox.org/virtualbox/debian yakkety non-free contrib" "virtualbox.org.list" \
            || print_error "Virtual box (add to package resource list)"

        update &> /dev/null \
            || print_error "Virtual box (resync package index files)"

    fi

    install_package "Virtual box" "virtualbox"


    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Zopfli" "zopfli"


    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Evolution mail" "evolution"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Evolution EWS Plugin" "evolution-ews"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "Evolution RSS Plugin" "evolution-rss"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_package "MySQL Workbench" "mysql-workbench"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    sudo rm -rf /opt/robomongo && sudo mkdir -p /opt/robomongo && cd /opt/robomongo
    sudo curl -L 'https://download.robomongo.org/0.9.0/linux/robomongo-0.9.0-linux-x86_64-0786489.tar.gz' | tar -xz  --strip-components=1
    sudo ln -s /opt/robomongo/bin/robomongo /usr/bin/robomongo

}

main() {

    print_in_purple "   Miscellaneous\n\n"

    update
    #upgrade
    printf "\n"
    install_apps
    printf "\n"
    autoremove

}

main
