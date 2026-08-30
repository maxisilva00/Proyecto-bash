#!/bin/bash

ENTRADA="$HOME/EPNro1/entrada"
SALIDA="$HOME/EPNro1/salida"
PROCESADO="$HOME/EPNro1/procesado"
ARCHIVO_LOG="$HOME/EPNro1/procesado.log"

EJECUTANDO=1

while [ "$EJECUTANDO" -eq 1 ]; do
    for archivo in "$ENTRADA"/*.txt; do
        if [ -f  "$archivo" ]; then
        cat "$archivo" >> "$SALIDA/$FILENAME.txt"
        mv "$archivo" "$PROCESADO/"
	    echo "$(date '+%d/%m/%Y %H:%M:%S') - Procesado archivo $(basename "$archivo")" >> "$ARCHIVO_LOG"
        fi
    done

    sleep 3
done
