// TLS private key creation

resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
// Key Pair create
resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2keyfile"
  public_key = tls_private_key.ec2_private_key.public_key_openssh
}

//Locally storing the key pair
resource "local_file" "ec2_key_file" {
  content  = tls_private_key.ec2_private_key.private_key_pem
  filename = "ec2keyfile.pem"
}

//Create EC2 Instance
resource "aws_instance" "myec2vm" {
  depends_on             = [local_file.ec2_key_file]
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  key_name               = aws_key_pair.ec2_key.id
  tags = {
    "Name" = "EC2 Demo 2"
  }

  
  
  provisioner "file" {
    source      = "../terraform_ec2/install.sh"  # Specify the local path of the script
    destination = "/tmp/install.sh"     # Specify the destination path on the instance

    connection {
      type        = "ssh"
      user        = "ec2-user"  # Specify the SSH user
      private_key = file("../terraform_vpc_setup/${local_file.ec2_key_file.filename}")  # Specify the path to your SSH private key
      host        = self.public_ip  # Specify the public IP address of the EC2 instance
    }
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"  # Specify the SSH user
      private_key = file("../terraform_vpc_setup/${local_file.ec2_key_file.filename}")  # Specify the path to your SSH private key
      host        = self.public_ip  # Specify the public IP address of the EC2 instance
    }
    inline = [
      "chmod +x /tmp/install.sh",  # Make the script executable
      "/tmp/install.sh"            # Execute the script
    ]
  }
}
