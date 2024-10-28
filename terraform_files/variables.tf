variable "ami" {
  description = "AMI_id for ubuntu EC2 instance"
}
variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}
variable "profile" {
  description = "profile configured using aws creds"
}
variable "region" {
  description = "AWS Region"
}
variable "subnet_az" {
  description = "AZ with the Region"
}
variable "key_name" {
  description = "Value for rsa key pair"
}
variable "security_group" {
  description = "aws security group name"
}
variable "vpc_cidr" {
  description = "value of subnet cidr"
  default     = "10.0.0.0/16"
}