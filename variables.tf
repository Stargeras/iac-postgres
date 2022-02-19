variable "kubeconfig" {
    type = string
    default = "~/.kube/config"
}
variable "postgres_password" {
    type = string
    default = "postgres123"
}
variable "storage_class" {
    type = string
    default = "local-path"
}
variable "postgres_namespace" {
    type = string
    default = "postgres"
}