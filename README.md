# practica-iaw-4.1

# Ejercicio 1
### Crea un grupo de seguridad para las máquinas del Backend con el nombre backend-sg.

### Añada las siguientes reglas al grupo de seguridad:

1. Acceso SSH (puerto 22/TCP) desde cualquier dirección IP.

2. Acceso al puerto 3306/TCP desde cualquier dirección IP.

````
aws ec2 create-security-group `
--group-name backend-sg `
 --description "Reglas para el backend"
````
![image](https://github.com/user-attachments/assets/2c0b2764-4870-4862-83d1-e41efbf145e4)

![image](https://github.com/user-attachments/assets/dd746d36-e29b-4d3e-8d57-aefbb1460561)


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
### Crea una instancia EC2 para la máquina del Backend con las siguientes características.

1. Identificador de la AMI: ami-08e637cea2f053dfa. Esta AMI se corresponde con la imagen Red Hat Enterprise Linux 9 (HVM).

2. Número de instancias: 1

3. Tipo de instancia: t2.micro

4. Clave privada: vockey

5. Grupo de seguridad: backend-sg

6. Nombre de la instancia: backend

````
aws ec2 run-instances `
    --image-id ami-08e637cea2f053dfa `
    --instance-type t2.micro `
    --count 1 `
    --key-name vockey `
    --security-groups backend-sg `
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=backend}]"
````

![image](https://github.com/user-attachments/assets/480e8968-b1e6-4adf-bc96-36dcb800f783)
![image](https://github.com/user-attachments/assets/7b43b4a5-55f8-442e-98bf-ae322125dc4c)


# Ejercicio 3

### Crear un script para crear la infraestructura de la práctica propuesta por el profesor.
Seguimos la misma estructura que en el ejercicio anterior, añadiendo las maquinas frontend 1, frontend2, backend, loadbalancer 
y servidor nfs

elegiremos la ultima vrsion de AMI de ubuntu server 

![OXPlxD9WsD](https://github.com/user-attachments/assets/39d7ccb5-7c64-4778-90ed-fa69a5afca7d)

y Crearemos 4 grupos de seguridad 1 para los frontales abriendo los puertos 80 y 20 tcp, uno para el balanceador con los mismos, otro para el backend con el puerto 3306 abierto para la base de datos y el 22, y otro para el servidor NFS con el puerto 2049 abierto oara el acceso NFS 

[ejercicio3-1.sh](https://github.com/marinaferb92/practica-iaw-4.1/blob/a13c6ded80765bd52f2cb4efeb29d4f63b50a080/ejercicio3-1.sh)

## Crear un script para eliminar la infraestructura de la práctica propuesta por el profesor.
[ejercicio3-2.sh
](https://github.com/marinaferb92/practica-iaw-4.1/blob/a13c6ded80765bd52f2cb4efeb29d4f63b50a080/ejercicio3-2.sh)


# Ejercicio 4
### Modifique los scripts del repositorio de ejemplo:

`https://github.com/josejuansanchez/practica-aws-cli`

### para que utilicen la AMI de la última versión de Ubuntu Server.

### También tendrá que modificar los scripts para que se ejecute el siguiente comando en las instancias durante el inicio.

`$ sudo apt update && sudo apt upgrade -y`

### En la documentación oficial puede encontrar más información sobre cómo ejecutar comandos en una instancia durante el inicio.

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
## Modifique los scripts del repositorio de ejemplo:

## https://github.com/josejuansanchez/practica-aws-cli
## para crear la infraestructura necesaria de la práctica propuesta por el profesor.

[ejercicio6](https://github.com/marinaferb92/practica-iaw-4.1/tree/a13c6ded80765bd52f2cb4efeb29d4f63b50a080/ejercicio6)

En el `.env` añadimos las variables de las instancias que faltan 

![image](https://github.com/user-attachments/assets/ecc60dab-1633-43eb-8b75-9dd575ae6863)

En añadimos `03-create_security_groups.sh` los grupos de seguridad y las reglas de cada grupo que falta 

![image](https://github.com/user-attachments/assets/db014bd6-6258-4c1e-aa28-553f711096ab)

[03-create_security_groups.sh](https://github.com/marinaferb92/practica-iaw-4.1/blob/26d65de41ead5183af75880ac32322e654cd85cb/ejercicio6/03-create_security_groups.sh)

En `04-create_instances.sh`hacemos lo mismo con las instancias que faltan 

![image](https://github.com/user-attachments/assets/2d4a2549-c275-45b6-a2d7-dfe334192856)

[04-create_instances.sh](https://github.com/marinaferb92/practica-iaw-4.1/blob/26d65de41ead5183af75880ac32322e654cd85cb/ejercicio6/04-create_instances.sh)

y en `05-create_elastic_ip.sh`tambien añadimos las maquinas que nos faltarian para añadirles una Ip elastica

![image](https://github.com/user-attachments/assets/cd5791ac-a8a6-4ec6-8d4b-2ac1c9c41eee)

[`05-create_elastic_ip.sh](https://github.com/marinaferb92/practica-iaw-4.1/blob/26d65de41ead5183af75880ac32322e654cd85cb/ejercicio6/05-create_elastic_ip.sh)
