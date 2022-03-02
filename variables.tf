variable "kubeconfig" {
  type    = string
  default = "~/.kube/config"
}
variable "postgres_password" {
  type    = string
  default = "postgres"
}
variable "postgres_newuser_username" {
  type    = string
  default = "admin"
}
variable "postgres_newuser_password" {
  type    = string
  default = "admin"
}
variable "storage_class" {
  type    = string
  default = "local-path"
}
variable "postgres_namespace" {
  type    = string
  default = "postgres"
}
variable "pgadmin_image" {
  type    = string
  default = "dpage/pgadmin4"
}
variable "pgadmin_namespace" {
  type    = string
  default = "pgadmin"
}
variable "pgadmin_replicas" {
  type    = number
  default = 1
}
variable "pgadmin_port" {
  type    = number
  default = 80
}
variable "pgadmin_email" {
  type    = string
  default = "admin@local.domain"
}
variable "pgadmin_password" {
  type    = string
  default = "admin"
}
variable "pgadmin_ingress_hostname" {
  type    = string
  default = "pgadmin.local.domain"
}