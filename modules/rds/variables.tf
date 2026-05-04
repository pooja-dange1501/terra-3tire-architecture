variable "db_subnet_ids" {
  type = list(string)
}

variable "db_sg" {}

variable "db_password" {
  sensitive = true
   default = "Pooja123"
}