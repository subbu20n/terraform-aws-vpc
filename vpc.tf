resource "aws_vpc" "main" {
    cidr_block = var.cidr_block 
    instance_tenancy = "default"
    enable_dns_hostnames = "true"

    tags = merge(
        var.vpc_tags,
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}"
        }
    )
}

resource "aws_internet_gateway" "main" {
    vpc_id  = aws_vpc.main.id 
     
    tags = merge(
        var.igw_tags,
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}"
        }
    ) 
}

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)
    vpc_id  = aws_vpc.main.id 
    cidr_block = var.public_subnet_cidrs[count.index]

    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true 

    tags = merge(
        var.public_subnet_tags,
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-public-${local.az_names[count.index]}"
        }
    )
}

resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id 
    cidr_block = var.private_subnet_cidrs[count.index]

    availability_zone = local.az_names[count.index]
    

    tags = merge(
        var.private_subnet_tags,
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-private-${local.az_names[count.index]}"
        }
    )
}

resource "aws_subnet" "database" {
    count = length(var.database_subnet_cidrs)
    vpc_id = aws_vpc.main.id 
    cidr_block = var.database_subnet_cidrs[count.index]

    availability_zone = local.az_names[count.index]
    
    tags = merge(
        var.database_subnet_tags,
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}-database-${local.az_names[count.index]}"
        }
    )
}

resource "aws_eip" "nat" {
    domain  = "vpc"

    tags = merge(
        var.eip_tags,
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}"
        }
    )
}

resource "aws_nat_gateway" "main" {
    allocation_id = aws_eip.nai.id 
    subnet_id = aws_subnet.public[0].id 

    tags = merge(
        var.nat_gateway_tags,
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}"
        }
    )
}