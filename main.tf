provider "aws" {
  region = "eu-west-1"
}

resource "aws_key_pair" "defectdojo_key" {
  key_name   = "defectdojo-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "defectdojo_spot" {
  ami           = "ami-00399ec92321828f5" # Amazon Linux 2 para eu-west-1
  instance_type = "t3.large"
  key_name      = aws_key_pair.defectdojo_key.key_name

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = "0.03"
      spot_instance_type = "one-time"
    }
  }

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              systemctl start docker
              usermod -a -G docker ec2-user
              mkdir -p ~/.docker/cli-plugins
              curl -SL https://github.com/docker/compose/releases/download/v2.24.2/docker-compose-linux-x86_64 \
                -o ~/.docker/cli-plugins/docker-compose
              chmod +x ~/.docker/cli-plugins/docker-compose
              mkdir -p /home/ec2-user/defectdojo
              cd /home/ec2-user/defectdojo
              curl -o docker-compose.yml https://raw.githubusercontent.com/Jose26Madrid/defectdojo/main/docker-compose-persistente.yml
              docker compose up -d
              chown -R ec2-user:ec2-user /home/ec2-user/defectdojo
              EOF

  tags = {
    Name = "DefectDojo-Spot"
  }
}
