resource "aws_instance" "web" {
  ami           = "ami-01f10c2d6bce70d90"
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "${var.project_name}-web"
  }



  provisioner "remote-exec" {
    inline = [
"sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ubuntu",
      "newgrp docker",
      "sudo docker pull yullit/lab6",
      "cd lab6",
      "sudo docker-compose up",
      "docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --interval 60"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}

resource "aws_security_group" "web_sg" {
  name_prefix = "${var.project_name}-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}