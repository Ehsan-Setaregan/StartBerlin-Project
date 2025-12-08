terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 1. Allgemeine Einstellungen: Region Frankfurt (General Settings)
provider "aws" {
  region = "eu-central-1"
}

# 2. SSH-Schlüssel erstellen (aus deinem lokalen Public Key)
resource "aws_key_pair" "deployer_key" {
  key_name   = "startberlin-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# 3. Firewall-Regeln definieren (Security Group)
resource "aws_security_group" "web_sg" {
  name        = "startberlin-sg"
  description = "Erlaube SSH und Web-Traffic"

  # Port 22 für SSH-Zugriff (Eingehend)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 5000 für die Flask-App (Eingehend)
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ausgehenden Traffic erlauben (für Updates & Docker Pull)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. EC2-Instanz erstellen und Konfigurieren
resource "aws_instance" "web_server" {
  ami           = "ami-0cebfb1f908092578" # Ubuntu 20.04 (Frankfurt)
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Installationsskript (User Data)
  user_data = <<-EOF
              #!/bin/bash
              # System aktualisieren und Docker installieren
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ubuntu

              # Docker Image herunterladen und starten (Container Deployment)
              sudo docker run -d -p 5000:5000 --restart always ehsansetaregan/startberlin-v1:latest
              EOF

  tags = {
    Name = "StartBerlin-Server"
  }
}

# 5. Ausgabe der Webseite-URL
output "website_url" {
  value = "http://${aws_instance.web_server.public_ip}:5000"
  description = "Die URL deiner StartBerlin Webseite"
}
