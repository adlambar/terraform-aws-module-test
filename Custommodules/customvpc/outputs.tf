output "vpc_id" {
  value = aws_vpc.devVPC.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.igw.id
}

output "public_subnet" {
  value = aws_subnet.public_subnet.id
}