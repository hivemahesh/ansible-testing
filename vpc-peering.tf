data "aws_vpc" "ansible_vpc" {
    id = "vpc-09f64b5668c33c275"       # we have to enter the controller vpc id, in our case we have created in default VPC 
}

data "aws_route_table" "ansible_vpc_rt" {
    subnet_id = "subnet-042a58de0e8bfa63a"  # we have to enter controller subnet id, in our case it is under default VPC
    # if subnet_id giving errors use route table id as below
    #route_table_id = data.aws_route_table.ansible_vpc_rt.id
}

resource "aws_vpc_peering_connection" "ansible-vpc-peering" {
    peer_vpc_id = data.aws_vpc.anible_vpc.id
    vpc_id = aws_vpc.default.id 
    auto_accept = true
    accepter {
      allow_remote_vpc_dns_resolution = true 
    }

    requester {
      allow_remote_vpc_dns_resolution = true 
    }

    tags = {
        Name = "Ansible-${var.vpc_name}-Peering"
    }
}

resource "aws_route" "peering-to-ansible-vpc" {
    route_table_id = aws_route_table.terraform-public.id 
    destination_cidr_block = "172.31.0.0/16"    #we need to enter our controller cidr range ***
    vpc_peering_connection_id = aws_vpc_peering_connection.ansible-vpc-peering.id 
}

resource "aws_route" "peering-from-ansible-vpc" {
    route_table_id = data.aws_route_table.ansible_vpc_rt.id 
    destination_cidr_block = "10.37.0.0/16"   #client machines vpc cidr range **
    vpc_peering_connection_id = aws_vpc_peering_connection.ansible-vpc-peering.id 
}