#!/bin/bash
opcion=0

if [ "$1" = "-d" ]; then
    echo "Modo desinstalacion activado..."
    pkill -f "consolidar.sh"
    rm -rf "$HOME/EPNro1/"
    echo "Se han eliminado todos los procesos y se ha borrado la carpeta EPNro1"
    exit 0
fi

while [ "$opcion" != "7" ]; do
	echo "1) Crear entorno"
	echo "2) Correr proceso"
	echo "3) Listado de alumnos por padron"
	echo "4) 10 notas mas altas "
	echo "5) Buscar alumno por padron"
	echo "6) Visualizar log"
	echo "7) Salir"
	read -p "Elija una opcion: " opcion

SALIDA="$HOME/EPNro1/salida/$FILENAME.txt"
	case $opcion in
	    1) mkdir -p $HOME/EPNro1/{entrada,salida,procesado}
	    	if [ -f "./consolidar.sh" ]; then
		 	cp ./consolidar.sh "$HOME/EPNro1"
		  	echo  "El archivo consolidar.sh ha sido movido con exito al directorio EPNro1"
		elif [ -f "$HOME/EPNro1/consolidar.sh" ]; then
			echo  "Error: EL archivo consolidar.sh ya se encuentra en el directorio EPNro1"
		else
   			echo  "Error: No se encontrÃ³ consolidar.sh ni aca ni en EPNro1."
		fi
		touch "$HOME/EPNro1/salida/$FILENAME.txt"
		touch "$HOME/EPNro1/procesado.log"
 	       ;;

	    2) if [ ! -f "$HOME/EPNro1/consolidar.sh" ]; then
			echo "Error:Primero se debe ejecutar la opcion 1 para copiar consolidar.sh"
	       elif pgrep -f "consolidar.sh" > /dev/null; then
		        echo "El proceso se encuentra ejecutandose en segundo plano"
	       else
		 	chmod +x "$HOME/EPNro1/consolidar.sh"
                 	"$HOME/EPNro1/consolidar.sh" &
		 	echo "Proceso consolidar.sh iniciado correctamente en segundo plano"
 	       fi
	       ;;

	    3) if [ -f "$SALIDA" ]; then
			echo "LISTADO DE ALUMNOS EN ORDEN POR PADRON"
			sort -k1,1n "$SALIDA"

	       else
			echo  "El archivo no existe."
	       fi
	       ;;

	    4) if [ -f "$SALIDA" ]; then
			echo "LAS 10 NOTAS MAS ALTAS DEL LISTADO"
            		sort -k5,5nr "$SALIDA" | head -n 10

               else
            		echo "El archivo no existe."
               fi
	      ;;

	    5) read -p "Ingrese el nro de padron que desee buscar: " padron
	       if [ -f "$SALIDA" ]; then
		 	resultado=$(grep "^$padron " "$SALIDA")
			if [ -n "$resultado" ]; then
           			echo "$resultado"
       		        else
           			echo "No se encontro un alumno con ese padron."
			fi
	       else
      			echo "El archivo no existe."
   	       fi														;;

	    6) if [ -f "$HOME/EPNro1/procesado.log" ]; then
                	cat "$HOME/EPNro1/procesado.log"
               else
                	echo "No existe el archivo de log."
               fi
	       ;;
	    7) echo -e "\nSaliendo...\n" ;;
	    *) echo -e "\nOpcion Invalida.\n" ;;
	esac
done
