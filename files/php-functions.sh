function makePhpShortformAliases {
    local arr config_php i phpa
    source /opt/phpfarm/config_php.sh
    for i in "${config_php[@]}"; do
        arr=(${i// / })
        phpa="php${arr[1]}='/opt/phpfarm/inst/php-${arr[0]}/bin/php'"
        alias $phpa;
    done;
}

function phpDefault {
    sudo /opt/phpfarm/inst/bin/switch-phpfarm $1
}

function phpErrors() {
    local ini ini_files services state
    state=$([[ ${1:-1} == 0 ]] && echo "Off" || echo "On");
    echo $([ ${1:-1} == 0 ] && echo "Disabling" || echo "Enabling")" PHP Error Display:"
    services=$(ls -a /etc/init.d/ | grep php);
    ini_files=$(ls -df /opt/phpfarm/inst/php-*/lib/php.ini);
    for ini in ${ini_files}; do
        sudo sed -i "s/display_startup_errors = .*/display_startup_errors = ${state}/g" ${ini}
        sudo sed -i "s/display_errors = .*/display_errors = ${state}/g" ${ini}
    done;
    for svc in ${services}; do
        echo -n "  * Restarting ${svc}... " && sudo service ${svc} restart > null && echo "done."
    done;
}

function phpRestart() {
    local ini ini_files services
    echo "Restarting PHP services"
    services=$(ls -a /etc/init.d/ | grep php);
    for svc in ${services}; do
        echo -n "  * Restarting ${svc}... " && sudo service ${svc} restart > null && echo "done."
    done;
}

function xdebug {
    local ini ini_files services state
    state=$([ ${1:-1} == 0 ] && echo ";");
    echo $([ ${1:-1} == 0 ] && echo "Disabling" || echo "Enabling")" X-Debug:"
    services=$(ls -a /etc/init.d/ | grep php);
    ini_files=$(ls -df /opt/phpfarm/inst/php-*/lib/php.ini);
    for ini in ${ini_files}
        do sudo sed -i "s/[;]*zend_extension=xdebug.so/${state}zend_extension=xdebug.so/g" ${ini};
    done;
    for svc in ${services}
        do echo -n "  * Restarting ${svc}... " && sudo service ${svc} restart > null && echo "done."
    done;
}

makePhpShortformAliases
