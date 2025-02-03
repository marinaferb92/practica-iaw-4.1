# practica-iaw-4.1

1.19.1 Ejercicio 1
Crea un grupo de seguridad para las máquinas del Backend con el nombre backend-sg.

Añada las siguientes reglas al grupo de seguridad:

Acceso SSH (puerto 22/TCP) desde cualquier dirección IP.

Acceso al puerto 3306/TCP desde cualquier dirección IP.

````
aws ec2 create-security-group `
--group-name backend-sg `
 --description "Reglas para el backend"
````
![image](https://github.com/user-attachments/assets/2c0b2764-4870-4862-83d1-e41efbf145e4)


````
 # Creamos una regla de accesso SSH
aws ec2 authorize-security-group-ingress `
    --group-name backend-sg `
    --protocol tcp `
    --port 22 `
    --cidr 0.0.0.0/0
````
![image](https://github.com/user-attachments/assets/541748b6-2a90-458c-93ff-c6c79ecd54eb)

````
# Creamos una regla de accesso HTTP
aws ec2 authorize-security-group-ingress `
    --group-name backend-sg `
    --protocol tcp `
    --port 80 `
    --cidr 0.0.0.0/0
 ````
![image](https://github.com/user-attachments/assets/8473fc3d-9895-4998-9f6a-ef251716165a)




1.19.2 Ejercicio 2
Crea una instancia EC2 para la máquina del Backend con las siguientes características.

Identificador de la AMI: ami-08e637cea2f053dfa. Esta AMI se corresponde con la imagen Red Hat Enterprise Linux 9 (HVM).

Número de instancias: 1

Tipo de instancia: t2.micro

Clave privada: vockey

Grupo de seguridad: backend-sg

Nombre de la instancia: backend

````
aws ec2 run-instances `
    --image-id ami-08e637cea2f053dfa `
    --instance-type t2.micro `
    --count 1 `
    --key-name vockey `
    --security-groups backend-sg `
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=backend}]"
````

![image](https://github.com/user-attachments/assets/e0df0bf1-39cd-41b4-8d3e-9a1aafd74443)


1.19.3 Ejercicio 3

Crear un script para crear la infraestructura de la práctica propuesta por el profesor.

Crear un script para eliminar la infraestructura de la práctica propuesta por el profesor.



1.19.4 Ejercicio 4
Modifique los scripts del repositorio de ejemplo:

https://github.com/josejuansanchez/practica-aws-cli

para que utilicen la AMI de la última versión de Ubuntu Server.

También tendrá que modificar los scripts para que se ejecute el siguiente comando en las instancias durante el inicio.

$ sudo apt update && sudo apt upgrade -y

En la documentación oficial puede encontrar más información sobre cómo ejecutar comandos en una instancia durante el inicio.

1.19.5 Ejercicio 5
Escriba un script de bash que muestre el nombre de todas instancias EC2 que tiene en ejecución junto a su dirección IP pública.

