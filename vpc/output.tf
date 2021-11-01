#vpc/output
output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet.*.id
}
output "private_subnet_id" {
  value = aws_subnet.private_subnet.*.id
}

output "db_subnet" {
  value = aws_db_subnet_group.db_subnet.*.id
}