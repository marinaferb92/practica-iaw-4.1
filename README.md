# practica-iaw-4.1

# Ejercicio 1
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




# Ejercicio 2
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


# Ejercicio 3

Crear un script para crear la infraestructura de la práctica propuesta por el profesor.
[ejercicio3-1.sh](https://github.com/marinaferb92/practica-iaw-4.1/blob/a13c6ded80765bd52f2cb4efeb29d4f63b50a080/ejercicio3-1.sh)
Crear un script para eliminar la infraestructura de la práctica propuesta por el profesor.
[ejercicio3-2.sh
](https://github.com/marinaferb92/practica-iaw-4.1/blob/a13c6ded80765bd52f2cb4efeb29d4f63b50a080/ejercicio3-2.sh)


# Ejercicio 4
Modifique los scripts del repositorio de ejemplo:

`https://github.com/josejuansanchez/practica-aws-cli`

para que utilicen la AMI de la última versión de Ubuntu Server.

También tendrá que modificar los scripts para que se ejecute el siguiente comando en las instancias durante el inicio.

`$ sudo apt update && sudo apt upgrade -y`

En la documentación oficial puede encontrar más información sobre cómo ejecutar comandos en una instancia durante el inicio.

entramos en AWS y vemos que la AMI de la última versión de Ubuntu Server es la siguiente

![OXPlxD9WsD](https://github.com/user-attachments/assets/39d7ccb5-7c64-4778-90ed-fa69a5afca7d)

lo añadimos en la pagina de variables del script 

![image](https://github.com/user-attachments/assets/6e3a86ef-6e60-4a4c-b1c5-e59147582496)
[.env](https://github.com/marinaferb92/practica-iaw-4.1/blob/a13c6ded80765bd52f2cb4efeb29d4f63b50a080/ejercicio4/.env)
y para ejecutar el comando $ sudo apt update && sudo apt upgrade -y añadimos la siguiente linea

````--user-data "sudo apt update && sudo apt upgrade -y"````
y lo añadimos en la página de creacion de instancias al final de cada una 

![image](https://github.com/user-attachments/assets/bef53619-fb5a-49c8-96d5-a54b2109e0cd)
[create_instances.sh](https://github.com/marinaferb92/practica-iaw-4.1/blob/a13c6ded80765bd52f2cb4efeb29d4f63b50a080/ejercicio4/04-create_instances.sh)

# Ejercicio 5
Escriba un script de bash que muestre el nombre de todas instancias EC2 que tiene en ejecución junto a su dirección IP pública.
[ejercicio5.sh](https://github.com/marinaferb92/practica-iaw-4.1/blob/a13c6ded80765bd52f2cb4efeb29d4f63b50a080/ejercicio5.sh)


# Ejercicio 6
Modifique los scripts del repositorio de ejemplo:

https://github.com/josejuansanchez/practica-aws-cli
para crear la infraestructura necesaria de la práctica propuesta por el profesor.

[ejercicio6](https://github.com/marinaferb92/practica-iaw-4.1/tree/a13c6ded80765bd52f2cb4efeb29d4f63b50a080/ejercicio6)
