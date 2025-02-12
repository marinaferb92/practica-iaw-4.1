#!/bin/bash
set -x

# Deshabilitamos la paginación de la salida de los comandos de AWS CLI
# Referencia: https://docs.aws.amazon.com/es_es/cli/latest/userguide/cliv2-migration.html#cliv2-migration-output-pager
export AWS_PAGER=""


# grupo de seguridad para el Balanceador
aws ec2 create-security-group \
    --group-name lb-sg \
    --description "Reglas para el balanceador de carga"

# Reglas para el balanceador
aws ec2 authorize-security-group-ingress \
    --group-name lb-sg \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
    --group-name lb-sg \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0  

# grupo de seguridad para Front-end
aws ec2 create-security-group \
    --group-name frontend-sg \
    --description "Reglas para el front-end"

# Reglas para Frontend
aws ec2 authorize-security-group-ingress \
    --group-name frontend-sg \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
    --group-name frontend-sg \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0  

# grupo de seguridad para NFS
aws ec2 create-security-group \
    --group-name nfs-sg \
    --description "Reglas para el servidor NFS"

# Reglas para acceso NFS
aws ec2 authorize-security-group-ingress \
    --group-name nfs-sg \
    --protocol tcp \
    --port 2049 \
    --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
    --group-name nfs-sg \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0 

# grupo de seguridad para backend
aws ec2 create-security-group \
    --group-name back-sg \
    --description "Reglas para la base de datos MySQL"

# Reglas para backend
aws ec2 authorize-security-group-ingress \
    --group-name back-sg \
    --protocol tcp \
    --port 3306 \
    --cidr 0.0.0.0/0

# Regla para acceso SSH al MySQL
aws ec2 authorize-security-group-ingress \
    --group-name back-sg \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0 


# 2. Lanzar las instancias EC2

# Lanzar Balanceador de carga 
aws ec2 run-instances \
    --image-id ami-08e637cea2f053dfa \  
    --count 1 \
    --key-name vockey \
    --security-groups lb-sg \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=loadbalancer}]"

# Lanzar Front-end Web 1
aws ec2 run-instances \
    --image-id ami-08e637cea2f053dfa \ 
    --instance-type t2.micro \
    --count 1 \
    --key-name vockey \
    --security-groups frontend-sg \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=frontend-1}]"

# Lanzar Front-end Web 2
aws ec2 run-instances \
    --image-id ami-08e637cea2f053dfa \  
    --instance-type t2.micro \
    --count 1 \
    --key-name vockey \
    --security-groups frontend-sg \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=frontend-2}]"

# Lanzar Servidor NFS
aws ec2 run-instances \
    --image-id ami-08e637cea2f053dfa \  
    --instance-type t2.micro \
    --count 1 \
    --key-name vockey \
    --security-groups nfs-sg \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=nfs-server}]"

# Lanzar Backend
aws ec2 run-instances \
    --image-id ami-08e637cea2f053dfa \ 
    --instance-type t2.micro \
    --count 1 \
    --key-name vockey \
    --security-groups back-sg \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=backend}]"
