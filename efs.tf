
resource "aws_efs_file_system" "efs" {
  creation_token = "coe-Darnold"
  tags = {
    Name = "coe-Darnold"
  }
}

resource "aws_efs_mount_target" "alpha" {
    count = 3
    file_system_id = "${aws_efs_file_system.efs.id}"
    subnet_id      = "${element(module.vpc.subnets_private, count.index)}"
    security_groups = ["${aws_security_group.allow_nfs.id}"]
}

resource "aws_security_group" "allow_nfs" {
  name        = "nfs"
  description = "Allow NFS Traffic"
  vpc_id      = "${module.vpc.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    security_groups = ["${module.vpc.sg_allhosts}"]
  }
}