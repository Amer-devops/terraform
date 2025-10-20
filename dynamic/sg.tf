resource "aws_security_group" "allow_all" { # resource block
  name   = "roboshop-strict-sg"

   egress {
    from_port        = 0 #from_port "0" to to_port "0" means all ports
    to_port          = 0
    protocol         = "-1" #-1 means all protocols
    cidr_blocks      = ["0.0.0.0/0"] # internet
  }

# block

  dynamic "ingress" {
    for_each = toset(var.ingress_ports)
    content{
        from_port        = ingress.value # here ingress is special key word
        to_port          = ingress.value
        protocol         = "tcp" # -1 means all protocols
        cidr_blocks      = ["0.0.0.0/0"] # internet
    }
  } 
  tags ={
    Name = "roboshop-strict-sg"

  }
}
