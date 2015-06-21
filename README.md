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

##Configuración de los scripts

PDO se utiliza para acceder y gestionar el origen de datos, por lo tanto la configuración se encuentra en el archivo
ConfigureWebApp.php

Configurando el acceso al origen de datos
Solamente se tiene que pasar los parámetros [logfile string, driverconfig array], el primer parámetro es el nombre de un archivo .log
para registrar todas las peticiones del sistema y así poder depurarlo, el segundo es un array de configuraciones para conectarse con
el controlador de la base de datos.

	ConfigureWebApp::initConfiguration(
		"logfile.log", 
		array(
			"u" => "database user",
			"p" => "database password",
			"h" => "host",
			"db" => "database name"
		)
	);

AJAX se utiliza para procesar las solicitudes de manera asíncrona, la configuración se encuentra en el archivo
AjaxRequester.js

Solamente se tiene que configurar el host al cual se enviarán las solicitudes.

	AjaxRequester.prototype.host = "http://sr3twebapp.zz.mu/";

Esta dirección se concatena con todas las solicitudes como base.


#Pruebas del sistema

Node.js provee gran escalabilidad para las tareas en las cuales se involucran actividades como el stream de datos,
en el presente proyecto se utilizan para probar la aplicación

##Servidores Proxy Virtuales
Estos proxies se usan para alterar las peticiones de las solicitudes http, un ejemplo sería un inicio de sesión.

	Petición antes del proxy
	user=user0&pass=efebc537b2b21b

	Petición después de pasar por el prxy
	user=user0&pass=efebc537b2b21b'or '1'='1
	
La petición que pasó por el proxy fue alterada, por eso es de gran importancia validar del lado del cliente y del servidor,
en nuestro proyecto se manejan filtros de expresiones regulares, claramente se busca que sean integros, por lo cual se hacen 
múltiples casos de prueba y verificar que el sistema sea seguro.

##Robots virtuales

Emula una entidad robótica, la cual es el robot SR3T --Smart Robot for Recoignition and Recollection of Trash, puede enviar
datos sensoriales, de manera virtual o usando cylon.js para enviarlos desde una tarjeta programable Arduino.

#Versiones

Versión 0.1

1. Se solucionaron los problemas con el núcleo del framework.
2. Login desarrollado.
3. Configuración de los scripts y patrones completa.

# Desarrolladores

1. <De Santiago Ruiz Diego Alberto/> [developerdiego0@gmail.com].
2. <Izquierdo Morales Alfredo./>
3. <Becerra Rodríguez Diego./> 
4. <Rodríguez Ávalos Gustavo./>