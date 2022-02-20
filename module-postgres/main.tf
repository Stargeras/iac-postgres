provider "helm" {
  kubernetes {
      config_path = "${var.kubeconfig}"
  }
}

resource "helm_release" "postgres" {
  name       = "postgres"
  namespace  = "${var.postgres_namespace}"
  create_namespace = "true"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"

  set {
      name = "global.storageClass"
      value = "${var.storage_class}"
  }
  set {
      name = "global.postgresql.auth.postgresPassword"
      value = "${var.postgres_password}"
  }
  set {
      name = "global.postgresql.auth.username"
      value = "${var.postgres_newuser_username}"
  }
  set {
      name = "global.postgresql.auth.password"
      value = "${var.postgres_newuser_password}"
  }
}