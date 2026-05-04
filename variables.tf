variable "myregion" {
  type = string
  default = "eu-north-1"
}
variable "myami" {
  default = "ami-073130f74f5ffb161"
}
variable "ins_type" {
  default = "t3.micro"
}
variable "key_name" {
  default = "doc_key"
}

variable "db_password" {
  type    = string
  default = "Pooja123"
}