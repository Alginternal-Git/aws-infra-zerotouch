resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "${var.environment}-${var.name}"
  public_key = tls_private_key.key.public_key_openssh

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.name}"
    Type = "ssh-key"
  })
}

resource "local_file" "private_key_file" {
  content          = tls_private_key.key.private_key_pem
  filename         = "${var.key_save_path}/${var.environment}-${var.name}.pem"
  file_permission  = "0400"
}

resource "aws_ssm_parameter" "private_key_ssm" {
  count = var.store_private_key_ssm ? 1 : 0

  name  = "/${var.environment}/ssh/${var.name}/private-key"
  type  = "SecureString"
  value = tls_private_key.key.private_key_pem

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.name}-private-key"
  })
}
