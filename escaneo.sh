#!/bin/bash
clear
echo "|-----------------------------------------|"
echo "|Bienvenido al escaneador de Abel Aravena |"
echo "|              Versión 1.0                |"
echo "|               01/09/23                  |"
echo "|Prohibida la reproducción parcíal o total|"
echo "|       del código sin autorización       |"
echo "|-----------------------------------------|"

echo ""
broadcast=$(ip addr| grep -oP 'inet \K\S+')
red=$(ifconfig| grep "broadcast" | awk '{print $6}')
ip=$(ip addr show | grep -E 'inet [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | grep -v '127.0' | awk '{print $2}' | cut -d'/' -f1)
echo "Tu dirección IP es: $ip"
echo ""

echo "Seleccione la función: "
echo "1-) Escaneo de red general"
echo "2-) Escaneo de una IP especifica"
echo "3-) Instalar NMAP (REQUERIDO)"
echo "4-) Desinstalar NMAP"
echo -n ">>>"
read op

case $op in
	1) clear
	   echo "La red general a escanear, ¿tiene alguna subred?"
	   echo "1-) Si"
	   echo "2-) No"
	   echo -n ">>>"
	   read op1
	   if [ $op1 -eq 1 ]
	   then
		echo "Ingrese el prefijo de subred (Ej: /23): "
		echo -n  ">>>"
		read prefix
		nmap $broadcast/$prefix
	   else
		nmap $red/24
	   fi
	   ;;

	2) clear
	   echo "Ingrese la IP específica: "
	   echo -n ">>>"
	   read ipEsp
	   nmap $ipEsp
	   ;;

	3) clear
	   sudo apt-get install nmap -y
	   ;;

	4) clear
	   sudo apt purge nmap -y
	   ;;
	*)
	  echo "Opción no válida"
	  ;;
esac

