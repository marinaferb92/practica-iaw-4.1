#!/bin/bash
set -x  # Modo de depuración para mostrar los comandos ejecutados

# Deshabilitar la paginación de salida de AWS CLI
export AWS_PAGER=""

# Obtenemos las instancias en ejecución junto con su nombre y dirección IP pública
aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value | [0], PublicIpAddress]" \
    --output table
