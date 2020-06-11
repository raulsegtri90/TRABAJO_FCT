# Trabajo-FCT

 	Uso de SSH, Vagrant, Ansible y Terraform.



# Requisitos previos.

- Tener instalado Vagrant y VirtualBox.
	https://www.virtualbox.org/wiki/Downloads
	
	https://www.vagrantup.com/downloads.html

- Descargar una imagen de ubuntu (en este caso bento/ubuntu-16.04):

	vagrant box add bento/ubuntu-16.04

- Creación de los Vagrantfile y fichero de instalación de Ansible.

	Estarán en los directorios vagrant-ansible, vagrant-node y vagrant-terraform



# Comenzando con el trabajo.

- Se Ejecutarán las máquinas con el siguiente comando dentro de cada directorio:
	
	vagrant up

- Una vez arrancadas las máquinas, se accede a la máquina de Ansible con el siguiente comando:

	ssh vagrant@IP

	** La contraseña por defecto para el usuario vagrant es vagrant

- Hay que añadir en el fichero /etc/ansible/hosts las IPs de todas las máquinas que se vayan a utilizar para probar la utilidad de Ansible. Una vez hecho esto, es recomendable hacer un ping a las demás máquinas para asegurarse de que todo está correcto.

	ping IP



# Configuración de SSH.

- Se debe acceder a todas las máquinas restantes una a una y hacer un "sudo su" para loguearse como root y hacer un "passwd" para añadir una contraseña al usuario root.

	sudo su
	passwd

	** En caso de no poder acceder a las máquinas por problemas de permisos comprobar que no haya equipos con esa IP en el fichero known_hosts (suele estar en el directorio /home/usuario/.ssh tanto en Windows como Linux).

- Una vez añadida la contraseña, acceder al fichero /etc/ssh/sshd_config como root y poner la línea "permitrootlogin" a yes para poder entrar a la máquina por ssh como root y reiniciar el servicio SSH también como sudo o añadir antes del comando el sudo.

	service ssh restart

- Una vez realizado este paso, desde la máquina de ansible, se creará un par de claves (pública y privada) para poder copiarlas en los demás equipos (tanto al usuario root como a vagrant). Para ello se usan los siguientes comandos:

	ssh-keygen -t rsa

	ssh-copy-id root@IP
	ssh-copy-id vagrant@IP

- Para comprobar que se puede realizar cualquier acción con ansible sobre estas máquinas se podría usar el siguiente comando para ver el nombre del host, por ejemplo:

	- En caso de comprobar en todos los equipos que estén en el fichero /etc/ansible/hosts a la vez:	
	
		ansible all -u root -a "hostname"

	- Comprobar en un equipo en concreto:

		ansible IP -u root -a "hostname"

		** Con la opción -a se puede ejecutar cualquier comando.



# Instalando en otras máquinas con ansible.

- Para este paso se van a utilizar los playbooks que se encargan de definir todas las tareas que se deben realizar sobre un conjunto de hosts clientes.

- Por ejemplo, en las máquinas del directorio "vagrant-node", se instalarán los servicios de apache2 y nginx llamando a los playbooks que están en el directorio /home/vagrant/projects de la máquina de ansible:

	ansible-playbook nombre_fichero_playbook.yaml

- También se puede instalar o actualizar en ansible con el siguiente comando sin necesidad de un playbook. La opción -m hace referencia a los módulos y en este caso para instalar se usará el "apt":

	ansible [all o IP] -u root -m apt -a "name=servicio state=latest"

- Una vez instalados los servicios apache2 y nginx se puede comprobar en el navegador con las IPs de las máquinas para comprobar que se han instalado correctamente.

- Para desinstalar un servicio se puede hacer con el siguiente comando:

	ansible [all o IP] -u root -m apt -a "name=servicio state=absent"



# Preparación de la máquina de Terraform.

- Una vez arrancada la máquina de Terraform, se accede a ella por ssh y habrá que instalar tanto wget como unzip previamente:

	sudo apt update

	sudo apt install wget

	sudo apt install unzip

- Creamos la ruta /downloads/terraform:

	mkdir /downloads/terraform -p
	cd /downloads/terraform

- Cuando se tengan estas herramientas instaladas, se descarga de la página oficial de Terraform la versión deseada copiando el enlace (en este caso para la máquina Linux 64bits):

	wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip

- Se extrae con este comando:

	sudo unzip terraform_0.11.13_linux_amd64.zip

- Y se instala de la siguiente forma:

	sudo install terraform /usr/local/bin/

- Se puede verificar que esté instalado ejecutando lo siguiente:

	terraform --version



# Uso de Terraform.

- Creación de los siguientes ficheros dentro del /home del usuario para crear una infraestructura simple de forma muy rápida:

	instance.tf
	providers.tf
	variables.tf
	vpc.tf

- En el /home del usuario habrá que crear también un directorio .aws con un fichero dentro llamado credentials. 
En este fichero habrá información necesaria de nuestra cuenta de AWS (en este caso la educate).
Para obtener estos datos hay que acceder a la cuenta de AWSEducate --> My Classrooms --> Go to classroom. 
Se redigirá a una página de vocareum. En esta página habrá que hacer clic en account details y en show en AWS CLI.

	** Muy importante tener en cuenta que en la versión educate cada vez que se cierra el navegador las keys se cambiarán y habrá que modificarlas en el fichero credentials.
	Además la región será la de Virginia (USA), ya que es la que funciona con AWSEducate.

- Una vez que tengamos todos los ficheros correctamente, tendremos que ejecutar una serie de comandos desde el directorio /home/usuario/terraform:

	terraform init 
		(inicia una configuración de Terraform)

	terraform plan 
		(crea un plan de ejecución)

	terraform apply 
		(aplica los cambios deseados para alcanzar la configuración deseada)

- Cuando se haya creado la instancia se puede comprobar en la cuenta de AWS en EC2 - instancias.



# Información de los ficheros.

- Se encontrarán comentarios con la función de lo más importante de cada fichero usado en la realización de esta práctica.



# Autor

Raúl Segura Tristancho
