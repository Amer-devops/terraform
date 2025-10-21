resource "aws_instance" "terraform" {
    ami = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    vpc_security_group_ids = [ aws_security_group.allow_all.id ]
    tags={
        Name = "terraform"
        Terraform = "true"
    }

    provisioner "local-exec" {
      command = "echo ${self.private_ip} > inventory "
      on_failure = continue # when provisioner "local-exec" fails it will continue by using this command
    }

    provisioner "local-exec" {
      command = "echo instance is destroyed"
      when = destroy
      
    }
    connection {
      type     = "ssh"
      user     = "ec2-user"
      password = "DevOps321"
      host     = self.public_ip
    }

    provisioner "remote-exec" {
      inline = [
        "sudo dnf install nginx -y",
        "sudo systemctl start nginx",
      ]
    }

    provisioner "remote-exec" {
      inline = [
        "sudo systemctl stop nginx",
        "echo 'successfully stopped nginx server' "
      ]
      when = destroy
    }
}

resource "aws_security_group" "allow_all" {
  name   = "allow-all-v1"

   egress {
    from_port        = 0 #from_port "0" to to_port "0" means all ports
    to_port          = 0
    protocol         = "-1" #-1 means all protocols
    cidr_blocks      = ["0.0.0.0/0"] # internet
  }

  ingress {
    from_port        = 0 # from_port "0" to to_port "0" means all ports
    to_port          = 0
    protocol         = "-1" # "-1" means all protocols
    cidr_blocks      = ["0.0.0.0/0"] # internet
  }
  tags ={
    Name = "allow-all-v1"
  }
}


 