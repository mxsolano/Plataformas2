#!/bin/bash

   #directorio para monitoreo
   directorio_a_monitorear="/home/mery/Desktop/plataformas"

   #.log
   log_file="registro2.log"

   #se empieza a monitorear el directorio
   inotifywait -m -r -e create,modify,delete "$directorio_a_monitorear" |
   while read -r directorio evento archivo; do
     fecha_hora=$(date +"%Y-%m-%d %H:%M:%S")
     echo "$fecha_hora - Se detectó un evento de $evento en $archivo" >> "$log_file"
   done
exit 0
