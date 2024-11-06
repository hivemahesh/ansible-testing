#distinct takes a list and returns a new list with any duplicate
#elements removed. 
#toset tkes a list will remove any duplicate elements and discard
#the ordering of the elements. 

#Instead of calling the tags everytime, we have declared locally
locals {
    new_public_subnet_cidrs = distinct(var.public_subnet_cidrs)
    new_private_subnet_cidrs = distinct(var.private_subnet_cidrs)
    new_environment = lower(var.environment)
    projid = format("%s-%s", lower(var.vpc_name), lower(var.projid))
}