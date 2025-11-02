output "aws_vpc" {
  value = aws_vpc.main.id 
}

output "aws_subnet_public" {
  value = aws_subnet.public[*].id 
}

output "aws_subnet_private" {
  value = aws_subnet.private[*].id 
}

output "aws_subnet_database" {
  value = aws_subnet.database[*].id 
}