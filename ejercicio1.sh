#!/bin/bash

if [ $# -eq 0 ]; then
  echo "error: Debe proporcionar un ID de proceso como argumento."
  exit 1
fi

# id del proceso ingresado
process_id="$1"

# para jalar la informacion del proceso 
informacion_proceso=$(ps -o command=,%cpu,%mem,pid,ppid,user,stat,exe= -p "$process_id")

# revisar que si exista el proceso
if [ -z "$informacion_proceso" ]; then
  echo "error: no se encontró el proceso \"$process_id\"."
  exit 1
fi

# Parsear la información del proceso
nombre_proceso=$(ps -p "$process_id" -o comm=) 
porcentaje_cpu=$(ps -p "$process_id" -o %cpu=)
consumo_memoria=$(ps p "$process_id" -o %mem=) 
pid=$(ps -p "$process_id" -o pid=)
parent_process_id=$(ps -p "$process_id" -o ppid=) 
usuario_propietario=$(ps -p "$process_id" -o user=)
status=$(ps -p "$process_id" -o stat=)
path=$(ps -p "$process_id" -o exe=) 

# imprimir en terminal
echo "Nombre del proceso:$nombre_proceso" 
echo "ID del proceso:$pid"
echo "ID del proceso padre:$parent_process_id"
echo "Usuario propietario:$usuario_propietario"
echo "Porcentaje de uso de CPU:$porcentaje_cpu%"
echo "Consumo de memoria:$consumo_memoria%" 
echo "Estado:$status"
echo "Ruta del ejectuable:$path"

exit 0 