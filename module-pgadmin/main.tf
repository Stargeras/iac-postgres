provider "kubernetes" {
  config_paths = [
    "${var.kubeconfig}"
  ]
}

resource "kubernetes_namespace" "pgadmin" {
  count = var.pgadmin_namespace != "default" ? 1 : 0
  metadata {
    name = "${var.pgadmin_namespace}"
  }
}

resource "kubernetes_deployment" "pgadmin" {
  metadata {
    name = "pgadmin"
    namespace = "${var.pgadmin_namespace}"
    labels = {
      app = "pgadmin"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "pgadmin"
      }
    }
    template {
      metadata {
        labels = {
          app = "pgadmin"
        }
      }
      spec {
        container {
          image = "${var.pgadmin_image}"
          name  = "pgadmin"
          env {
            name = "PGADMIN_DEFAULT_EMAIL"
            value = "${var.pgadmin_email}"
          },
          {
            name = "PGADMIN_DEFAULT_PASSWORD"
            value = "${var.pgadmin_password}"
          },
        }
      }
    }
  }
  depends_on = [kubernetes_namespace.pgadmin]
}

resource "kubernetes_service" "pgadmin" {
  metadata {
    name = "pgadmin"
    namespace = "${var.pgadmin_namespace}"
  }
  spec {
    selector = {
      app = "pgadmin"
    }
    port {
      port        = "${var.pgadmin_port}"
      target_port = "${var.pgadmin_port}"
    }
    type = "ClusterIP"
  }
  depends_on = [kubernetes_namespace.pgadmin]
}

resource "kubernetes_ingress_v1" "pgadmin" {
  metadata {
    name = "pgadmin"
    namespace = "${var.pgadmin_namespace}"
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "${var.pgadmin_ingress_hostname}"
      http {
        path {
          backend {
            service {
              name = "pgadmin"
              port {
                number = "${var.pgadmin_port}"
              }
            }
          }
          path = "/"
        }
      }
    }
    tls {
      hosts = [
        "${var.pgadmin_ingress_hostname}"
      ]
    }
  }
  depends_on = [kubernetes_namespace.pgadmin]
}
