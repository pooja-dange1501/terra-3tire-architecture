output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "web_subnet" {
  value = aws_subnet.websubnet.id
}

output "app_subnet" {
  value = aws_subnet.appsubnet.id
}

output "db_subnet" {
  value = aws_subnet.dbsubnet.id
}

output "web_sg" {
  value = aws_security_group.web-sg.id
}

output "app_sg" {
  value = aws_security_group.app-sg.id
}

output "db_sg" {
  value = aws_security_group.db-sg.id
}