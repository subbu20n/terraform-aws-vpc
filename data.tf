data "aws_availability_zones" "available" {
    state = "available"
}

data "aws_vpc" "default" {
    default = true 
}

#output "azs_info" {
#    value = data.aws_availability_zones.available 
#}