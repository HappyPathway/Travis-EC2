module "vpc" {
  source         = "git@github.com:FoghornConsulting/m-vpc.git"
  # version        = "v0.2.9"
  tag_costcenter = "dave@foghornconsulting.com"
  tag_customer   = "DuMB"

  subnet_map {
    public   = "3"
    private  = "3"
    isolated = 0
  }
}

module "layer2" {
  #source = "git@github.com:FoghornConsulting/m-layer2.git"
  #version = "v0.1.9"
  source = "git@github.com:FoghornConsulting/m-layer2.git"

  tag_costcenter    = "dave@foghornconsulting.com"
  tag_customer      = "DuMB"
  vpc_id            = "${module.vpc.id}"
  sg_allhosts       = "${module.vpc.sg_allhosts}"
  subnets_elb       = "${module.vpc.subnets_public}"
  subnets_instances = "${module.vpc.subnets_private}"
  r53_zone_name     = "superscalability.com."
  r53_domain        = "wordpress.superscalability.com."
  acm_domain        = "*.superscalability.com"
  tag_application   = "wordpress"
  tag_environment   = "coe"
  tag_name          = "coe-Darnold"
  enable_r53        = true
  append_script = "${data.template_file.user_data.rendered}"
  asg_min = 1
  asg_max = 1
  asg_desired = 1
  key_name = "darnold"
}
