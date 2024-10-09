#!/bin/bash
LOG_FILE=skrypt.log
BACKUP_DIR=/backup

function log_print () {
    echo "`date +"%Y_%m_%d %H:%M:%S"` $1" >> $LOG_FILE
    echo "$1"
}
function print () {
    echo "$1"
}

function install() {
    apt-get update
    apt-get install --no-install-recommends -y python3 redis python3-pip uvicorn

    cd /root/DEVOPS/01_BASH/Python_app
    pip3 install --no-cache-dir -r requirements.txt

    echo "[Unit]
    Description=Python API
    After=network.target

    [Service]
    WorkingDirectory=/root/DEVOPS/01_BASH/Python_app
    Type=simple
    Environment=REDIS_HOST=127.0.0.1
    ExecStart=/usr/bin/uvicorn main:app --host 0.0.0.0 --port 5002
    StandardInput=tty-force

    [Install]
    WantedBy=multi-user.target" > /lib/systemd/system/python-api.service

    systemctl daemon-reload
    systemctl enable python-api.service
    systemctl start python-api.service
}

function backup() {
    log_print "Rozpoczynam backup"
    print "Robie backup Redisa"
    redis-cli save >> /dev/null
    if [ ! -e /var/lib/redis/dump.rdb ]; then
        log_print "Wystąpił błąd podczas tworzenia backupu"
        exit 2
    fi
    mkdir -p ${BACKUP_DIR}
    mv /var/lib/redis/dump.rdb ${BACKUP_DIR}/`date +"%Y_%m_%d"`_redis.backup
    log_print "Backup zakończony sukcesem"
}

function rollback() {
    log_print "Rozpoczynam rollback"
    redis-cli DEL counter >> /dev/null
    service redis-server stop
    cp ${BACKUP_DIR}/* /var/lib/redis/dump.rdb
    if [ $? != 0 ]; then
        log_print "Wystąpił błąd podczas rollbacku"
        exit 2
    fi
    service redis-server start
    rm ${BACKUP_DIR}/*
    log_print "Rollback zakończony"
}


CHOICE=$(whiptail --title "Co chcesz odpalić" --menu "Choose an option" 25 30 10 \
"1" "Install" \
"2" "Backup" \
"3" "Rollback" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus == 0 ]; then
    case "$CHOICE" in
        "3") rollback ;;
        "2") backup ;;
        "1") install ;;
    esac
else
    echo "Nacisnąłeś cancel"
fi