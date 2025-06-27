variable "project" {
    type  = string 
}

variable "environment" {
    type = string 
}

variable "cidr_block" {
    default = ["0.0.0.0/0"]
}