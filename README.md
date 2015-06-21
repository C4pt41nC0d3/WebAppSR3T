# WebAppSR3T

WebAppSR3T es una aplicación web, creada para la clase de Gestión de Proyectos; esta aplicación
está desarrollada en PHP, implementando en microframework Silex de Symfony.



# Archivos de configuración

Los archivos de configuración son de gran importancia para la presente aplicación, porque mediante estos se define el origen de datos, procesamiento de solicitudes, cifrado de datos, etc.

1. ConfigureWebApp.php: Se encarga de empaquetar la configuración del framework y la aplicación [ruta: backend/app/ConfigureWebApp.php].
2. AjaxRequester.js: Se encarga de hacer solicitudes usando AJAX [ruta: cdn/libs/js/AjaxRequester.js].

#Instalación y configuración
##Linux y Mac OSx

Para instalar el origen de datos en linux y Mac OSx, solamente se ejecuta el script init.sh [ruta: backend/datasource/init.sh] en la terminal.

	user@host~$./init.sh

Este script crea las funciones, vistas, tablas, además de crear un test unitario, en el cual se prueba toda la base de datos.

	Instalando el origen de datos desde comandos:
	
	#Restaurar la base de datos
	user@host~$mysql -u <user> -P <port> -h <host> -p < sr3tdb.sql
	
	#Crear el API de la base de datos
	user@host~$mysql -u <user> -P <port> -h <host> -p < databaseAPI.sql

	#Crear un test unitario
	user@host~$mysql -u <user> -P <port> -h <host> -p < unitest.sql
	
##Windows

Para intalar el origen de datos en Windows, solamente se restaura en el servidor mysql correspondiente.



# Desarrolladores

1. De Santiago Ruiz Diego Alberto [developerdiego0@gmail.com].
2. Izquierdo Morales Alfredo.
3. Becerra Rodríguez Diego. 
4. Rodríguez Ávalos Gustavo.