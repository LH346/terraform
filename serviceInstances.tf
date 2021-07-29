resource "aws_key_pair" "lh346" {
  key_name   = "connect"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3b9W/2jCKfUtL7TKPs5JrViEP6Bpz+cG1q9b3PjHFt88qsY8GHEQuh59qQWaQcGlkcY3WnzjcvJouiLV+mGk9BeSARTyq0VD+HV1IFytSMRsgDZVy21ZzXg+KBUC4DAtRu7KWwi01cg7evXAjukrUxT+Ad/UOLVfsIV4JIudnrQblbLPAY95X4dkOoV575ZzV0LJLEvfl8rSjG+DfwIJIqkGtwplWu+1ZWSUKMZmeemUVXuFy+lE1TrnK/FZARETQT6ps73a8/rahZnNbwk8VKPprHzbw59QhV2FWvazIbE8nYYWZXLGy5DjlxoOKg0NpIYSgl7mqi4ZEw0B3hPzCxCrP5xWjVNvxJkWEFFcObMT/Zq6OXMty86j9EPFa/fVWmCcIq34ZHyVZoMoUch1dPaKXARbDP7KIBx2DNeLrG+GXZbVTgo5hem0tMa7av5BXnjMHmydw51x7F6HfcZvZlOsaBwOMQ6kgsC1fkv3l3mcoVWRxDTyn1hj3/9euZcc= lh346@EPUAKYIW1283"
}

resource "aws_instance" "bastion" {
  ami = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pubWebProd02.id
  vpc_security_group_ids = [aws_security_group.publicSubnet.id]
  key_name               = aws_key_pair.lh346.key_name

  connection {
    type        = "ssh"
    user        = "ec2-user"
  }
  tags = {
    "Name" = "Bastion"
    "Terraform" = "True"
  }
}
