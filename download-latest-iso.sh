#!/bin/bash
printf '%s inicio rotina download latest iso\n' "$(date)" >> download-latest-iso.log

md5_local=$(cat arquivos/md5.txt)
printf 'MD5 do arquivo local %s\n' "$md5_local" >> download-latest-iso.log

wget -O downloads/md5-remoto.txt http://localhost:8000/md5.txt

md5_remoto=$(cat downloads/md5-remoto.txt)
printf 'MD5 do arquivo remoto %s\n' "$md5_remoto" >> download-latest-iso.log

if [ $md5_local -eq $md5_remoto]
then
    printf 'MD5 iguais\n' >> download-latest-iso.log
else
    printf 'MD5 diferentes, entao baixando arquivo ISO\n' >> download-latest-iso.log
    wget -O downloads/arquivo-remoto.iso http://localhost:8000/arquivo.iso

    printf 'Movendo arquivo MD5 baixado para pasta arquivos\n' >> download-latest-iso.log
    #rm arquivos/md5.txt
    mv downloads/md5-remoto.txt arquivos/md5.txt

    printf 'Movendo arquivo ISO baixado para pasta arquivos\n' >> download-latest-iso.log
    #rm arquivos/arquivo.iso
    mv downloads/arquivo-remoto.iso arquivos/arquivo.iso
fi

printf '%s fim rotina download latest iso\n' "$(date)" >> download-latest-iso.log