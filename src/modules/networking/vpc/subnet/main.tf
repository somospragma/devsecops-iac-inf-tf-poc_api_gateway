resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_blocks
  availability_zone = var.subnet_availability_zone

  tags = {
    "Name" = var.subnet_name
  }
}

