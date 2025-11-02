data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "default" {  #i am asking aws lo unde default vpc data adugutunna 
  default = true   
}
/* output "azs_info" {
  value = data.aws_availability_zones.available  
}  */

data "aws_route_table" "main" {  #main routetable fetch(search) cheyamani cheptunna 
  vpc_id = data.aws_vpc.default.id  

  filter {
    name = "association.main" 
    values = ["true"]
  } 
}   