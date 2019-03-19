# Ejecución de script para la VM mediante GXemul

## Configuración y uso básica de los script:

1. Si no está instalado el `sshd` en el **HOST**, hacer:

```
sudo apt-get install openssh-server
```

Lo mismo con `sshfs`:

```
sudo apt-get install sshfs
```

2. Ejecutar `./runEmul.sh` (chmod u+x runEmul.sh) y 
logearse al 'root' con la contraseña `orga6620`.

3. En el NetBSD que se abrió (la xterm), correr:

```
ssh -R 2222:127.0.0.1:22 usuario_host@172.20.0.1
```

Para comunicarse con el **HOST** y logearse con la contraseña del usuario del **HOST** 'usuario_host'. Cuando lo pida, agregar el **HOST** al archivo 'known_hosts' del **GUEST**.

4. Abrir una nueva terminal, y ejecutar el script `runRemoteShellRoot.sh` para comenzar a trabajar. 
Cuando pide el tipo de emulador de terminal, poner **vt1000** (sin colores), o **xterm** para uno más moderno.

5. Si es la primera vez que se ejecuta el emulador, conviene crear un archivo `createTunnel.sh` con la línea del punto '3'.
Para mayor comodidad, se provee uno en el directorio 'sw' del **HOST**, que se  lo puede transferir desde el **HOST** (abriendo una nueva terminal) con el comando:

```
scp -P2222 -r ./createTunnel.sh root@127.0.0.1:/root
```

Otra forma mejor de transferir es la del punto 11, ya que es más fácil.

6. Si es la primera vez que se ejecuta el emulador, conviene configurar VIM con el '.vimrc' incluido en el directorio 'sw' del **HOST**. 
Transferirlo desde el **HOST** con:

```
scp -P2222 -r ./_.vimrc root@127.0.0.1:/root
```

y luego remover el `.vimrc` en el **GUEST**, y cambiarle el nombre del archivo transferido con: `mv _.vimrc .vimrc`. Notar que se colocoó un guión bajo (underscore) al nombre para que **Ubuntu** no lo muestre como archivo oculto.

Otra forma mejor de transferir es la del punto 11, ya que es más fácil.

7. Si es la primera vez que se ejecuta el emulador, hay que usar la imagen virgen 'netbsd-pmax.img' descomprimiéndola del archivo 'gxemul-6620-20070927.tar.bz2', ya que si no va a quedar configurado el SSHD para utilizar el **HOST** de la máquina donde estuvo siendo corrida la imagen. 
En caso de problemas, modificar el archivo 'known_hosts' dentro del directorio `~/.ssh`.

8. Para transferir archivos desde el **GUEST**, correr en el **HOST** el siguiente comando:

```
scp -P2222 root@127.0.0.1:~/archivo /home/usuario_host/
```

9. Para que todo funcione, en el **HOST** no puede estar siendo utilizada la IP 10.0.0.1 (o en el router).
Esto puede visualizarse en la tabla de ruteo mediante el comando `route`.

10. Para finalizar todas las sesiones, ejecutar el comando `halt` en la consola del **GUEST**, a fin de que la sesión finalice correctamente.

## Montado de un directorio compartido hostOS-guestOS

Si no se desea estar copiando todo constantemente, se puede montar en el **HOST** un directorio que representa el
directorio `/root` (el 'home' del 'root') del **GUEST**. Abriendo una terminal nueva en el **HOST**:

1. Creo un directorio vacio por unica vez en el **HOST**, o utilizar el provisto 'guestFS'.

```
mkdir mi_directorio_montado
```
2. Monto la carpeta root de NetBSD en ese directorio.

```
sudo sshfs -p 2222 -C root@127.0.0.1:/root $(pwd)/guestFS
```

Ahora simplemente se copian las cosas dentro de ese directorio. Si es la primera vez que se ejecuta el emulador, conviene copiar los archivos `_.vimrc` (reemplazar el que ya están en el **GUEST**) y `createTunnel.sh`.

También se puede correr el script `mountGuestFS.sh` para automatizar el montaje.

Para poder ingresar a 'mi_directorio_montado' desde Ubuntu, como el script 'mountGuestFS.sh' se ejecutó en modo SU, hay que abrir un explorador de archivos en modo SU, por ejemplo, en Ubuntu con Nautilus: `sudo nautilus`

De ahora en más se puede trabajar en el directorio montado sin tener problemas de permisos, por ejemplo, editando el código desde Ubuntu con un editor de texto.
