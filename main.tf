terraform {
  required_providers {
    helm = {
      source = "helm"
    }
  }

  backend "remote" {
    workspaces {
      name = "cluster"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "releases" {
  for_each         = var.releases
  name             = each.key
  namespace        = each.value.namespace
  create_namespace = each.value.create_namespace
  repository       = each.value.repository
  chart            = each.value.chart
  values           = [for value_file in each.value.values : file(value_file)]
}
