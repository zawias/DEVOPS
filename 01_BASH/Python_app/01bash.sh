#!/bin/bash
date="date +%Y_%m_%d"
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
if [ -e /lib/systemd/system/python-api.service ] ; then
    echo "Aplikacja jest już zainstalowana"
else
    echo "Instaluje aplikacje..."
    install
    echo "Aplikacja zainstalowana"
fi

function backup() {
    echo "Wykonuje backup bazy Redis..."
    redis-cli save
    echo "Backup wykonany"
    echo "Przenoszę backup do kataloagu /backup"
    cp /var/lib/redis/dump.rdb /backup/`date -I`_redis.backup
    if [ -e /backup/`date -I`_redis.backup ] ; then
        echo "Backup przeniesiony poprawnie"
    else
        echo "Błąd w przenoszeniu pliku !"
    fi
}

function recovery() {
    echo "Rozpoczynam odtworzenie bazy Redis..."
    echo "Czyszcze baze..."
    redis-cli DEL counter
    echo "Baza wyczyszczona"
    echo "Zatrzymuję Redisa"
    service redis-server stop
    echo "Redis zatrzymany"
    echo "Przywracam plik z bazą"
    cp /backup/`date -I`_redis.backup /var/lib/redis/dump.rdb
    echo "Startuje Redisa"
    service redis-server start
    echo "Redis wystartował"
    echo "Kasuje stary backup"
    rm /backup/`date -I`_redis.backup
    echo "Plik skasowany"
}

PS3="+++? "
echo "Co wybierasz?"
select y in Backup Recover Quit
do
case $y in
    "Backup") backup ;;
    "Recover") recovery  ;;
    "Quit") exit ;;
    *) echo "Nic nie wybrałeś"
esac
break
done