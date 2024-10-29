resource "aws_key_pair" "key" {
  key_name   = "tfkey"
  public_key = file(var.Public_key)
}

resource "aws_instance" "instance1" {
  ami                    = var.AMI[var.Region]
  instance_type          = "t2.small"
  subnet_id              = aws_subnet.vpc1-pub-s1.id
  vpc_security_group_ids = [aws_security_group.vpc1-sg1.id]
  key_name               = aws_key_pair.key.key_name
  tags = {
    Name = "my_instance"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > lmn.txt"
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> lmn.txt"
  }

  connection {
    user        = var.user
    private_key = file("tfkey")
    host        = self.public_ip
  }
}

resource "aws_ebs_volume" "volume1" {
  availability_zone = var.Zones["a"]
  size              = 5
  tags = {
    Name = "volume for my_instance"
  }
}

resource "aws_volume_attachment" "volume1-attach" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.volume1.id
  instance_id = aws_instance.instance1.id
}

output "PublicIP" {
  value = aws_instance.instance1.public_ip
}

