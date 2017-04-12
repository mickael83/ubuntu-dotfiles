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

secure_mysql() {
    aptitude -y install expect

    // Not required in actual script
    MYSQL_ROOT_PASSWORD=r00t

    SECURE_MYSQL=$(expect -c "
    set timeout 10
    spawn mysql_secure_installation
    expect \"Enter current password for root (enter for none):\"
    send \"$MYSQL\r\"
    expect \"Change the root password?\"
    send \"n\r\"
    expect \"Remove anonymous users?\"
    send \"y\r\"
    expect \"Disallow root login remotely?\"
    send \"y\r\"
    expect \"Remove test database and access to it?\"
    send \"y\r\"
    expect \"Reload privilege tables now?\"
    send \"y\r\"
    expect eof
    ")

    echo "$SECURE_MYSQL"

    aptitude -y purge expect
}

install_databases() {
    URL='https://dev.mysql.com/get/mysql-apt-config_0.8.4-1_all.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE
    update

    echo "mysql-server-5.6 mysql-server/root_password password root" | sudo debconf-set-selections
    echo "mysql-server-5.6 mysql-server/root_password_again password root" | sudo debconf-set-selections
    install_package "MySQL" "mysql-server"
    execute "secure_mysql" "Secure MySQL"

    install_package "MongoDB" "mongodb"
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
