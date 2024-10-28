resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.vpc_cidr
  availability_zone       = var.subnet_az
  map_public_ip_on_launch = true
}