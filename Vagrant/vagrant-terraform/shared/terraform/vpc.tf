# Creación del recurso vpc que llama a la variable del fichero 
# variables.tf y al que se le asigna un tag llamado vpc_FCT

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr
  enable_dns_hostnames = false
  enable_dns_support = false
  tags = {
    Name = "vpc_FCT"
  }  
}
