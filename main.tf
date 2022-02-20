module "postgres" {
    source = "./module-postgres"
    kubeconfig = "${var.kubeconfig}"
    postgres_password = "${var.postgres_password}"
    postgres_newuser_username = "${var.postgres_newuser_username}"
    postgres_newuser_password = "${var.postgres_newuser_password}"
    storage_class = "${var.storage_class}"
    postgres_namespace = "${var.postgres_namespace}"
}

module "pgadmin" {
    source = "./module-pgadmin"
    kubeconfig = "${var.kubeconfig}"
    pgadmin_namespace = "${var.pgadmin_namespace}"
    pgadmin_replicas = "${var.pgadmin_replicas}"
    pgadmin_port = "${var.pgadmin_port}"
    pgadmin_image = "${var.pgadmin_image}"
    pgadmin_email = "${var.pgadmin_email}"
    pgadmin_password = "${var.pgadmin_password}"
    pgadmin_ingress_hostname = "${var.pgadmin_ingress_hostname}"
}