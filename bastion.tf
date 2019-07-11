module "bastion" {
    source = "git@github.com:HappyPathway/terraform-aws-bastion.git"
    public_subnet_id = "${element(module.vpc.subnets_public, 0)}"
    vpc_id = "${module.vpc.id}"
    ssh_access = "0.0.0.0/0"
    key_name = "darnold"
    admin_sg = "${module.vpc.sg_allhosts}"
    network_name = "DuMB-Wordpress"
}