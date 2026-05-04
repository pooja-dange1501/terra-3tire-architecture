resource "aws_db_subnet_group" "dbsubnet" {
  name = "db-subnet"

  subnet_ids = var.db_subnet_ids
}

resource "aws_db_instance" "rds" {
  allocated_storage = 20
  engine = "mysql"
  instance_class = "db.t3.micro"

  username = "admin"
  password = var.db_password
 db_name  = "mydb"
  db_subnet_group_name = aws_db_subnet_group.dbsubnet.id
  vpc_security_group_ids = [var.db_sg]

  skip_final_snapshot = true
}