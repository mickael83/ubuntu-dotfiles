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

    install_package "Debian configuration utilities" "debconf-utils"

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

install_mysql() {

    echo "deb http://repo.mysql.com/apt/ubuntu/ trusty mysql-apt-config" | sudo tee /etc/apt/sources.list.d/mysql.list > /dev/null
    echo "deb http://repo.mysql.com/apt/ubuntu/ trusty mysql-5.7" | sudo tee --append /etc/apt/sources.list.d/mysql.list > /dev/null
    echo "deb-src http://repo.mysql.com/apt/ubuntu/ trusty mysql-5.7" | sudo tee --append /etc/apt/sources.list.d/mysql.list > /dev/null

    execute \
        "sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5072E1F5 && sudo apt-get update" \
        "MySQL apt repository"
    # update

    MYSQL_ROOT_PASSWORD="r00t"
    sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/data-dir select ''"
    sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password $MYSQL_ROOT_PASSWORD"
    sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password $MYSQL_ROOT_PASSWORD"
    install_package "MySQL" "mysql-server"
    sudo usermod -d /var/lib/mysql/ mysql > /dev/null

    #sudo sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/my.cnf
    # mysql -uroot -p -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;'

    # Install Expect
    sudo apt-get -qq install expect > /dev/null

    # Build Expect script
    tee ~/secure_our_mysql.sh > /dev/null << EOF
spawn $(which mysql_secure_installation)

expect "Enter password for user root:"
send "$MYSQL_ROOT_PASSWORD\r"

expect "Press y|Y for Yes, any other key for No:"
send "y\r"

expect "Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG:"
send "2\r"

expect "Change the password for root ? ((Press y|Y for Yes, any other key for No) :"
send "n\r"

expect "Remove anonymous users? (Press y|Y for Yes, any other key for No) :"
send "y\r"

expect "Disallow root login remotely? (Press y|Y for Yes, any other key for No) :"
send "y\r"

expect "Remove test database and access to it? (Press y|Y for Yes, any other key for No) :"
send "y\r"

expect "Reload privilege tables now? (Press y|Y for Yes, any other key for No) :"
send "y\r"

EOF

    # Run Expect script.
    # This runs the "mysql_secure_installation" script which removes insecure defaults.

    execute \
        "sudo expect ~/secure_our_mysql.sh" \
        "MySQL secure installation"

    # Cleanup
    rm -v ~/secure_our_mysql.sh > /dev/null # Remove the generated Expect script
    sudo apt-get -qq purge expect > /dev/null # Uninstall Expect, commented out in case you need Expect

}

install_databases() {
    # Mongo
    install_package "MongoDB" "mongodb"

    # MySQL
    install_mysql
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
