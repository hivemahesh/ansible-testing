resource "aws_route_table" "terraform-public" {
    vpc_id = aws_vpc.default.id

    tags = {
        Name = "${var.vpc_name}-MAIN-RT"
        Terraform-Managed = "Yes"
        Env = lcoal.new_environment
        ProjectID = local.projid
    }
}

#VPC Peering routes are getting recreated when we apply. TO overcome this issue
#Routing table is created without any route & routes for igw, peering are created
#separately. 

resource "aws_route" "igw-route" {
    route_table_id = aws_route_table.terraform-public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id 
}

resource "aws_route_table_association" "terraform-public" {
    #count = 4 # 0 1 2
    count = length(local.new_public_subnet_cidrs)

    #Using * is called splat syntax
    subnet_id = element(aws_subnet.public-subnets.*.id, count.index)
    route_table_id = aws_route_table.terraform-public.id
}
