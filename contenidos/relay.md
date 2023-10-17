# DHCP + RELAY
## Configurcion Servidor DHCP
Creamos un servidor dhcp y lo configuramos : 
- /etc/dhcp/dhcpd.conf

![image](/contenidos/8.png)

- /etc/network/interfaces

![image](/contenidos/9.png)

- /etc/default/isc-dhcp-server
  
![image](/contenidos/10.png)

## Configurcion Relay
Configuramos una nueva maquina con dos redes internas ( al principio pondremos una en adaptador puente para instalar el isc-dhcp-relay)
- 1º instalamos el isc-dhcp-relay
- 2º Configuramos los ficheros 
- /etc/network/interfaces
  
![image](/contenidos/11.png)

- /etc/default/isc-dhcp-server
  
![image](/contenidos/12.png)

en SERVERS ponemos la ip de nuestro servidor dhcp y en interfaces ponemos la tarjeta por la cual van a pasar las peticiones dhcp, es decir las peticiones procedente de los clientes.


## Comprobación:

![image](/contenidos/13.png)


## Para que salga a internet el cliente : 
En el servidor:
- /etc/sysctl.conf
  
![image](/contenidos/14.png)

En el cliente: 
Lo configuramos en red interna.
Comprobamos que nos ha dado bien la ip:

![image](/contenidos/15.png)

configuramos el fichero:
- /etc/network/interfaces
  
![image](/contenidos/16.png)

- systemctl restart networking
- ip a (comprobamos que nos ha dado la ip bien de nuevo)
  
![image](/contenidos/17.png)

Ya estaria todo configurado

- [Script DHCP](/contenidos/relay1.sh)
- [Script Relay](/contenidos/relay2.sh)
