variable "ami" {}
variable "instance_type" {}

variable "web_subnet_id" {}
variable "app_subnet_id" {}

variable "web_sg" {}
variable "app_sg" {}
variable "rds_endpoint" {}
variable "db_password" {
  sensitive = true
   default = "Pooja123"
}
