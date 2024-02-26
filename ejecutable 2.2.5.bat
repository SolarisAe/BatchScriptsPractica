@echo off
setlocal enabledelayedexpansion 
:menu
cls
REM los echos. sirven para dejar espacios
echo.
echo ==================BIENVENIDO SELECCIONE OPCION=================
echo 1 - Registrar Usuario 
echo 2 - Iniciar sesion
echo 3 - Salir de la aplicacion
echo ===============================================================
echo.
REM Una variable es un nombre que designa un valor y como su nombre indica puede variar. 
REM Gracias a esto podemos guardar valores y darles nombre.
REM ej: set nombre= valor
REM /p te permite darle al usuario la opcion de meter valores
set /p opcion= Ingrese un numero para seleccionar una opcion y presione Enter para continuar: 

REM con %variable% hacemos llamamiento a una variable
if "%opcion%" =="1" goto registro
if "%opcion%" =="2" goto Inicio
if "%opcion%" =="3" goto Salir 

echo Comando no reconocido; por favor presione Enter y seleccione los numeros: 1,2 o 3.
REM pause>Nul sirve para que no aparezca nada en nuestra consola
REM Se utiliza > para escribir algo y >> para añadir algo a un documento que ya tenia algo escrito y 
REM se añadiría una linea mas abajo.
pause>NUL
goto :menu

:registro 
SET /p user= Introduzca un Nombre de Usuario:
SET /p pass= Introduzca la contraseña:
SET /p comp= Vuelva ha introducir la contraseña:
IF !comp! == !pass! (
    echo El registro se ha realizado con exito
    goto anotacion
) else (
    echo La contraseña introducida es erronea.
    pause>NUL
    goto :menu
)

REM ANOTACION REGISTRA EL USUARIO CON EXITO
:anotacion
echo !user!/!pass! >> Registro.txt
pause>NUL
goto :menu




:Inicio
SET contador=1
echo Bienvenido al inicio de sesion
SET /p uini= Introduzca el nombre de Usuario:
FOR /f "tokens=%contador% delims=/" %%a IN (Registro.txt) DO (      
    REM Aqui establezco un contador y delimito lo que lee el /f en Registro.txt y le voy diciendo que el contador añada un +1 cada vez que lea una nueva linea
IF !uini! == %%a (                                                  
    REM aqui tengo un problema con las variables uini a
    goto contraseña
) else (
    SET /a contador+=1 
)
)
echo Usuario no encontrado
pause>NUL                           
REM Por algun motivo si no pones al final del FOR en el apartado inicio; pasa directamente a contraseña
goto :menu                          
REM Es por eso que esta el goto :menu fuera del FOR

:contraseña
SET contador=1
SET /p upass= Introduzca la contraseña:
SET Cuenta=!uini!/!upass!
REM LA VARIABLE CUENTA NO ERA CAPAZ DE LEER PUES ANTES HABIA UN ESPACIO Y AL LEER SIEMPRE LEIA EL ESPACIO PRIMERO:SET Cuenta= !uini!/!upass!; EL ESPACIO DE CUENTA= !UINI! ESTA MAL 
REM !!!!!CUIDADO CON LOS ESPACIOS A LA HORA DE DECLARAR VARIABLES!!!!!!!!!
REM JUNTAMOS VARIABLES EN UNA SOLA PARA PODER HACER LAS COMPARACIONES                             
FOR /f "tokens=%contador%" %%b IN (Registro.txt) DO ( 
IF !Cuenta! EQU %%b (
    echo Bienvenido !uini!
    pause>NUL
    goto :Uinter
) else (
    SET /a contador+=1
)
)
echo Contraseña incorrecta
pause>NUL
goto :menu
 

:Uinter
cls
echo Seleccione que desea hacer 
pause>Nul
