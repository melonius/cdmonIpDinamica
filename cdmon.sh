#!/bin/bash
USUARIO=miusuario
PASSMD5=0f70ffff714080342a53fe4c88418bf3
HOST=mipaginaweb.com
IP_DNS_ONLINE=$(host $HOST dinamic1.cdmon.net | grep -m1 $HOST | awk {'print $4'})
IP_ACTUAL=`wget -q -O - http://automation.whatismyip.com/n09230945.asp`
if [ "$IP_ACTUAL" ]; then
	if [ "$IP_DNS_ONLINE" != "$IP_ACTUAL" ]; then
			CHANGE_IP="https://dinamico.cdmon.org/onlineService.php?enctype=MD5&n=$USUARIO&p=$PASSMD5"
			RESULTADO=`wget $CHANGE_IP -o /dev/null -O /dev/stdout --no-check-certificate`
			echo "$(date)_____cambio de IP en los servidores DNS dinamicos de CDMON.com     resultado devuelto: $RESULTADO "
			echo  "en Servidor = $IP_DNS_ONLINE  (antiguo)"  
			echo  "mi Ip       = $IP_ACTUAL  (actualizado)" 
		else 
#			echo "$(date)_____coinciden los IPs: en cdmon: $IP_DNS_ONLINE ;mi Ip     =$IP_ACTUAL"
	fi
fi
############################ Fin del script



############################ Explicación
# para cdmon: no es perl, es bash shell
# este es un script para detectar los cambios de la Ip dinamica de nuestro servidor y si cambia actualizar esta IP en los DNS de cdmon.com
# yo utilizo mi propio servidor web apache alojado en uno de mis ordenadores
# a este archivo le he dado el nombre de cdmon.sh y lo he guardado en /usr/local/bin
# lo ejecuto con un CRON: */10 * * * * /usr/local/bin/cdmon.sh  >>~/log/log_cdmon    (Atencion: tiene que existir previamente el directorio)

# linea 2: USUARIO = es el nombre de usuario para entrar en CDMON.COM.   Debes cambiarlo por el tuyo (el que hay es ficticio)
# linea 3: PASSWORDMD5 = Es la contraseña para entrar en CDMON.COM encriptada con el algoritmo MD5.    Debes cambiarlo por la tuya (el que hay es ficticio)
# 			Puedes encriptar tu contraseña con MD5 en https://www.cdmon.com/md5.php
#			o en  http://www.cuwhois.com/herramienta-seo-genera-md5.php (o en el que a ti te guste)
#			intente hacerlo con echo "password"|md5sum  y no me da el mismo resultado: MISTERIO! si alguien sabe porque, me gustaría saberlo. 
# linea 4: HOST = uno cualquiera de tus dominio/subdominio que se desees actualizar.   Debes cambiarlo por el tuyo (el que hay es ficticio)
# linea 5: pregunta a cdmon.net que IP tiene guardada para nuestro dominio
# linea 6: pregunta a whatismyip.com cual es mi IP
# linea 7: if:  previene error de ip vacía
# linea 8: if:  si no son iguales:
# linea 9y10: cambia la IP con el protocolo suministrado por cdmon.com
# linea 11,12,13: muestra los resultados, como esta ejecutado desde el cron lo escribirá en el archivo log_cdmon
# linea 15: solo la uso para depurar (descomentandola) y observar si esta ejecutandose bien y escribiendo en el archivo log_cdmon

############################ PROTOCOLO
#	explicación de como funciona el protocolo en cdmon:		http://info.cdmon.com/index.php?page=uso-de-la-api-de-actualizacion-de-ip-dinamica

############################ Créditos
# Versión 0.1 de Melchor Monleon (9 de julio de 2011)
# contacto mel arroba ctav punto es
# cambios en esta versión respecto a sus precursoras:
# 1. he sustituido el envio del correo electrónico por un archivo log  (ya no es necesario tener "links2" instalado previamente)
# 2. obtengo "cual es mi IP" de http://automation.whatismyip.com/n09230945.asp
# 3. elimino el loop while y el sleep y utilizo cron de gnu/linux para 
# 4. no uso la variable cip en la llamada, ya que ejecuto desde mi propio servidor
#
# basado en
# Versión de www.EstebanWeb.cl (1ra Actualización el 16 de enero del 2008)
# blog: www.estebanweb.cl/linux   . Nota de Melchor: parece que no funciona el enlace
# Idea original por Enrique Garcia Alvarez <kike>
# kike arroba eldemonionegro punto com
# http://www.eldemonionegro.com/wordpress/archivos/2006/01/15/script-para-cdmon/
# Modificado por primera vez por Javier xavy en ghalician punto es
# Modificado por segunda vez en diciembre del 2007 por Esteban estebanweb.cl
# www.estebanweb.cl
# Comentado por estebanweb.cl
# contacto a esteban iglesias manriquez (todo junto) arroba gmail (.) com
# puedes tener más info en www.estebanweb.cl/linux
# Y más sobre este script en --->
# http://www.estebanweb.cl/linux/index.php/12/2007/%c2%a1el-problema-de-la-ip-dinamica-solucionado-script-para-actualizar-ip-en-cdmon/
# Software libre (licencia GNU)para la administracion de dominios en cdmon 
# Copyright (C) 2005-2006 
# estebanweb.cl dice: 
# Me gustaría que me avisaras de cualquier cambio que se le realiza al script
# Y que si lo publicas en tu web pongas los créditos de arriba
# contacto a esteban iglesias manriquez (todo junto) arroba gmail (.) com
#
# Puedes leer la licencia en en español en http://www.viti.es/gnu/licenses/gpl.html
############################# Licencia
#    Este programa es software libre. Puede redistribuirlo y/o modificarlo
#    bajo los teminos de la Licencia Publica General de GNU segun es publicada
#    por la Free Software Foundation, bien de la version 2 de dicha Licencia
#    o bien (segun su eleccion) de cualquier version posterior.
#
#    Este programa se distribuye con la esperanza de que sea util, 
#    pero SIN NINGUNA GARANTIA, incluso sin la garantia MERCANTIL implicita o
#    sin garantizar la CONVENIENCIA PARA UN PROPOSITO PARTICULAR. 
#    Vease la Licencia Publica General de GNU para mas detalles.
#    Deberia haber recibido una copia de la Licencia Publica General junto
#    con este programa. Si no ha sido asi, escriba a la 
#    Free Software Foundation, Inc., en 675 Mass Ave, Cambridge, MA 02139, EEUU.
#    MIRA AQUI PARA SABER MAS ==>>  http://www.gnu.org/copyleft/gpl.html
############################# License
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#    SEE HERE FOR MORE ==>>  http://www.gnu.org/copyleft/gpl.html
######################################################################################
#											FIN
