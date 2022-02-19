module "postgres" {
    source = "./module-postgres"
    kubeconfig = "${var.kubeconfig}"
    postgres_password = "${var.postgres_password}"
    storage_class = "${var.storage_class}"
    postgres_namespace = "${var.postgres_namespace}"
}