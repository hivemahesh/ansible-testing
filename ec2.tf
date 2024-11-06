data "aws_ami" "my_ami" {
    most_recent = true
    name_regex = "^DevSecOps"  # Using the below account, it will take the AMI ID starting with DevSecOps ** 
    owners = ["905418333628"]
}

resource "aws_instance" "webservers" {
    # count = local.new_environment == "Production" ? 3 : 1
    count = 3
    ami = data.aws_ami.my_ami.id    # DevSecOps-Ansible-Image-2024-10-31T18-40-51Z  this is the AMI which we created 
    instance_type = lookup(var.instance_type, local.new_environment)
    key_name = var.key_name
    subnet_id = element(aws_subnet.public-subnet.*.id, count.index)
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true 
    tags = {
        Name = "${var.vpc_name}-PublicServer-${count.index + 1}"
        Terraform-Managed = "Yes"
        Env = local-new_environment
        ProjectID = local.projid 
        ManagedBy = "Terraform"
    }
}