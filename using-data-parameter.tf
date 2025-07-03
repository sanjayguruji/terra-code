ata "aws_security_group" "previous-sg" {
  id = "sg-07befa9a91f333167" #existing security group id
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "devops-lti"
  vpc_security_group_ids = [data.aws_security_group.previous-sg.id]
  tags = {
    Name = "HelloWorld"
  }
}
