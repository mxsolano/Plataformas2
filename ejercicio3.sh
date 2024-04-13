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
# para monitorear el ejectuable
while ejecutable_corriendo; do
  current_time=$(awk '{print int($1)}' /proc/uptime)
  elapsed_time=$((current_time - t_inicio))
  if [ "$elapsed_time" -le "$tiempo_m" ]; then
    ps -C "$ejecutable" -o %cpu,%mem | tail -n 1 >> "$log_file" #carga al archivo de registstro lo obtenido 
    sleep 1
  else
    break
  fi
done

# grafica con gnuplot
gnuplot <<EOF
set terminal png
set output 'grafica.png'
set title 'Consumo de CPU y Memoria de $ejecutable'
set xlabel 'Tiempo (segundos)'
set ylabel 'Porcentaje'
plot "$log_file" using 1 with lines title 'CPU', \
     "$log_file" using 2 with lines title 'Memoria'
EOF
exit 0
