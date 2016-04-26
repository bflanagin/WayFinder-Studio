#!/bin/bash
HOST='openseed.vagueentertainment.com'
USER='bflanagin'
PASSWD='A1ml355E!'

ftp -n -v $HOST << EOT
ascii
user $USER $PASSWD
prompt
cd /var/www/openseed/devs/Vag-01001011/VagRpg-45454/img/avatar
put Tile.qml
bye
EOT

