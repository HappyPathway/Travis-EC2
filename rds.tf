resource "random_string" "username" {
  length = 16
  special = false
}
resource "random_string" "password" {
  length = 24
  special = false
}

resource "aws_rds_cluster" "default" {
  depends_on = [
      "aws_db_subnet_group.default"
  ]
  cluster_identifier      = "wordpress"
  engine                  = "aurora"
  database_name           = "wordpress"
  master_username         = "${random_string.username.result}"
  master_password         = "${random_string.password.result}"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  db_subnet_group_name = "wordpress"
  skip_final_snapshot = true
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  depends_on = [
      "aws_rds_cluster.default"
  ]
  count              = 1
  identifier         = "wordpress-${count.index}"
  cluster_identifier = "${aws_rds_cluster.default.id}"
  instance_class     = "db.r4.large"
  db_subnet_group_name = "wordpress"
}

resource "aws_db_subnet_group" "default" {
  name       = "wordpress"
  subnet_ids = ["${module.vpc.subnets_private}"]
}

# harness push
