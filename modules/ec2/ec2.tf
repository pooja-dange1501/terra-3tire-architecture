resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.web_subnet_id
  vpc_security_group_ids = [var.web_sg]
  key_name = "mykey"



  user_data = templatefile("${path.module}/web.sh.tpl", {
    app_private_ip = aws_instance.app.private_ip
  })
  tags = { Name = "webserver" }
}

resource "aws_instance" "app" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.app_subnet_id
  vpc_security_group_ids = [var.app_sg]
  key_name = "mykey"

  user_data = templatefile("${path.module}/app.sh.tpl", {
    rds_endpoint = var.rds_endpoint
    db_password  = var.db_password
   
  })

  tags = { Name = "appserver" }
}