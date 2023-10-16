# CONFIGURAR SERVIDOR DHCP + FAILOVER + CLIENTE

enp0s3= adaptador puente ( sale a internet)
enp0s8= red interna (Servidor DHCP)

1º instalamos los repositorios de debian 12, apt upgrade, apt update, instalamos “isc-dhcp-server”

2º deshabilitamos el network manager con “apt-get purge network-manager”

3º limpiamos la ip que nos dieron antes con “sudo ip addr flush dev enp0s3” para configurar nuestra ip estática

4º Configuramos los siguientes ficheros:

- /etc/network/interfaes
  ![image](/contenidos/1.png)


- /etc/default/isc-dhcp-server
  ![image](/contenidos/2.png)


- /etc/dhcp/dhcpd.conf

  
  ![image](/contenidos/3.png)



Hacemos “systemctl restart networking” y “systemctl restart isc-dhcp-server”

Creamos otra máquina con red interna para que nuestro servidor le de IP

## PARA QUE DE PING EN LA CLIENTE HAY QUE HACER EN EL SERVIDOR:

![image](/contenidos/4.png)

## Y EN EL CLIENTE:

![image](/contenidos/5.png)

## CONFIGURACION DE FAILOVER:
Clonamos el servidor, le cambiamos la ip a uno de ellos (para que no tengan la misma) y
hacemos lo siguiente:

## FAILOVER PRIMARIO
- /etc/dhcp/dhcpd.conf
![image](/contenidos/6.png)

## FAILOVER SECUNDARIO
- /etc/dhcp/dhcpd.conf

  
![image](/contenidos/7.png)


Hacemos ”systemctl restart isc-dhcp-server.service” y estaría listo.

  
