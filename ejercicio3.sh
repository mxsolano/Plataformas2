#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Uso: $0 <nombre_del_ejecutable>"
  exit 1
fi

# nombre del ejecutable
ejecutable="$1"

# tiempo de muestro
tiempo_m=20 

# Nombre del archivo de registro
log_file="monitoring.log"

# tiempo de inicio
t_inicio=$(awk '{print int($1)}' /proc/uptime)

# revisa que el ejecutable este arriba
ejecutable_corriendo() {
  pgrep "$ejecutable" > /dev/null
}

# se cargan a log file los datos requeridos 
if [ ! -e "$log_file" ]; then
  echo "Tiempo CPU Memoria" > "$log_file"
fi
