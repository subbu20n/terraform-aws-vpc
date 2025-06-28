data "aws_availabilty_zones" "available" {
    state = "available"
}

#output "azs_info" {
#    value = data.aws_availability_zones.available 
#}