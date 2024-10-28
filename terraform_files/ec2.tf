resource "aws_instance" "server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key1.key_name
  vpc_security_group_ids = [aws_security_group.sg1.id]
  subnet_id              = aws_subnet.subnet1.id
  tags = {
    Name = "Anil-Flask-Terraform"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/anil/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "../flask_app/app.py"
    destination = "/home/ubuntu/app.py"
  }

  provisioner "file" {
    source      = "../flask_app/templates/home.html"
    destination = "/home/ubuntu/templates/"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Starting provisioning on the remote instance...'",

      "sudo apt update -y",

      "sudo apt install -y python3 python3-pip python3-venv",

      "cd /home/ubuntu/",

      "python3 -m venv venv && . venv/bin/activate && pip install flask",

      ". venv/bin/activate && python3 app.py",

      "echo 'Provisioning completed successfully!'"
    ]
  }
}
