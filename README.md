# Docker con QEMU MIPS para Organización de Computadoras (66.20)

## Uso

### Lanzar la máquina MIPS

1. Crear la imagen

```bash
docker build . --tag qemu-mips-image
```

2. Lanzar el contenedor por primera vez
```bash
docker run -it --network="host" -v /path/to/project:/project --name qemu-mips qemu-mips-image
```  
Reemplazar `/path/to/project` con la ruta completa a tu proyecto que quieras tener disponible en la máquina MIPS

3. Lanzar el contenedor las siguientes veces
```bash
docker container start -ai qemu-mips
```

### Montar nuestro proyecto dentro de la máquina MIPS

Esto es para montar la carpeta directamente y no tener que estar copiando los archivos entre las máquinas todo el tiempo.

1. Crear la carpeta donde vamos a montar el proyecto

```bash
mkdir /mnt/project
```

2. Introducir el siguiente comando para montar la carpeta del proyecto
```bash
mount -t 9p -o trans=virtio,version=9p2000.L host0 /mnt/project
```

NOTA: podemos crear un alias para este comando ya que lo vamos a tener que introducir cada vez que iniciemos la máquina virtual

```bash
echo "alias mp='mount -t 9p -o trans=virtio,version=9p2000.L host0 /mnt/project'" >> ~/.bashrc
```

3. Dirigirse a la carpeta montada
```bash
cd /mnt/project
```

4. Ver que tenemos todos los archivos de nuestro proyecto
```bash
ls
```

### Instalar paquetes
1. Conectarse a internet
```bash
dhclient
```

2. Actualizar repositorios
```bash
apt update
```

3. Instalar paquetes
```bash
apt install gcc
apt install gdb
```

## Errores conocidos

- Si compilamos un programa y generamos el ejecutable dentro de la carpeta montada puede ser que no te deje ejecutarlo. Tenés que crear el ejecutable en una carpeta *nativa* de la máquina mips, por ejemplo `/home`
