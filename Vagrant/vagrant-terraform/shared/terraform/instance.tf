/* Creación de la instancia llamada FCT_RAUL a la que hay que 
asignarle una ami (Una Imagen de Amazon Machine proporciona la información necesaria para lanzar una instancia).
El tipo de instancia EC2 será t2.micro */

# Información sobre instancias EC2:
# https://aws.amazon.com/es/ec2/instance-types/

resource "aws_instance" "web" {
  ami           = ""
  instance_type = "t2.micro"

  tags = {
    Name = "FCT_RAUL"
  }
}
