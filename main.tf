resource "aws_instance" "web" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = var.instance_type
  key_name      = "laba6"

  tags = {
    Name = "${var.project_name}-web"
  }

  user_data = <<-EOF
#!/bin/bash
sudo apt-get update
              sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
              sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
              sudo apt-get update
              sudo apt-get install -y docker-ce
              sudo usermod -aG docker ubuntu
              sudo systemctl start docker
              sudo systemctl enable docker
      docker pull yullit/lab6:latest
      docker run -p 80:80 yullit/lab6:latest
      docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --interval 60
      EOF




  vpc_security_group_ids = [aws_security_group.web_sg.id]
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
    cidr_blocks = ["185.111.119.117/32"]
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