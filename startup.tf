data "aws_region" "current" {}

data "template_file" "docker_yaml" {
    template = "${file("${path.module}/templates/docker-compose.yaml.tpl")}"
    vars = {
        db_host = "${aws_rds_cluster_instance.cluster_instances.endpoint}"
        db_user = "${random_string.username.result}"
        db_password = "${random_string.password.result}"
        db_dbname = "wordpress"
        db_port = 3306
    }
}
# file-system-id.efs.aws-region.amazonaws.com
data "template_file" "user_data" {
    template = "${file("${path.module}/templates/startup.sh.tpl")}"
    vars = {
        efs_mount_id = "${aws_efs_file_system.efs.id}"
        docker_compose = "${data.template_file.docker_yaml.rendered}"
    }
}