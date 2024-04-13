!/bin/bash

#guardo el nombre del proceso y el comando a ejecutar
nombre_proceso="$1"
comando="$2"

#para monitorear el proceso recibido
monitoreo_proceso(){
  if pgrep -x "$nombre_proceso" > /dev/null; then
    echo "el proceso esta corriendo"
  else
    echo "EL proceso no esta corriendo"

    $comando & echo "Proceso $nombre_proceso inciado"
  fi
}

while true; do
  monitoreo_proceso
  sleep 5 #el script espera 5 segundos entre cada verificacion
done
exit 0
