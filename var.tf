variable "app_name" {
  default = "simple-php"
}

locals {
  cluster_name = "eks-${var.app_name}-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 4
  special = false
}