#!/bin/bash

ORIGEN=$1
DESTINO=$2


if [[ "$1" == "-help" ]]; then
    echo "Uso: $0 <directorio_origen> <directorio_destino>"
    echo "Este script crea un backup comprimido del directorio origen"
    echo "y lo guarda en el destino con la fecha actual."
    exit 0
fi

echo "Empezando backup..."


if [ -z "$ORIGEN" ] || [ -z "$DESTINO" ]; then
    echo "Error: faltan argumentos."
    echo "Usa: $0 -help para más información."
    exit 1
fi


if [ ! -d "$ORIGEN" ]; then
    echo "Error: el directorio '$ORIGEN' no existe."
    exit 1
fi


if [ ! -r "$ORIGEN" ]; then
    echo "Error: no se puede leer el directorio de origen."
    exit 1
fi

if [ ! -d "$DESTINO" ]; then
    echo "El directorio destino no existe. Creando..."
    mkdir -p "$DESTINO"
fi

if [ ! -w "$DESTINO" ]; then
    echo "Error: no se puede escribir en el directorio de destino."
    exit 1
fi

FECHA=`date +%Y%m%d`
NOMBRE=`basename $ORIGEN`
ARCHIVO=${NOMBRE}_bkp_${FECHA}.tar.gz

echo "Creando: $ARCHIVO"

tar -czf "$DESTINO/$ARCHIVO" -C "`dirname $ORIGEN`" "`basename $ORIGEN`"

echo "Backup completado con éxito."
