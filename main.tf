terraform {
  required_providers {
    helm = {
      source = "helm"
    }
  }

  backend "remote" {
    organization = "kunish"
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

resource "helm_release" "longhorn" {
  name              = "longhorn"
  repository        = "https://charts.longhorn.io"
  chart             = "longhorn"
  namespace         = "longhorn-system"
  create_namespace  = true
  dependency_update = true
}

resource "helm_release" "prometheus" {
  name              = "prometheus"
  repository        = "https://prometheus-community.github.io/helm-charts"
  chart             = "prometheus"
  namespace         = "prometheus"
  create_namespace  = true
  dependency_update = true
  depends_on = [
    helm_release.longhorn
  ]
}

resource "helm_release" "metallb" {
  name              = "metallb"
  repository        = "https://metallb.github.io/metallb"
  chart             = "metallb"
  namespace         = "metallb-system"
  create_namespace  = true
  dependency_update = true
  values            = [file("helm/metallb/values.yml")]
}

resource "helm_release" "ingress-nginx" {
  name              = "ingress-nginx"
  repository        = "https://kubernetes.github.io/ingress-nginx"
  chart             = "ingress-nginx"
  namespace         = "ingress-nginx"
  create_namespace  = true
  dependency_update = true
  depends_on = [
    helm_release.metallb
  ]
}

resource "helm_release" "external-dns" {
  name              = "external-dns"
  repository        = "https://charts.bitnami.com/bitnami"
  chart             = "external-dns"
  namespace         = "external-dns"
  create_namespace  = true
  dependency_update = true
  values            = [file("helm/external-dns/values.yml")]
}

resource "helm_release" "cert-manager" {
  name              = "cert-manager"
  repository        = "https://charts.jetstack.io"
  chart             = "cert-manager"
  namespace         = "cert-manager"
  create_namespace  = true
  dependency_update = true
  values            = [file("helm/cert-manager/values.yml")]
  depends_on = [
    helm_release.longhorn
  ]
}
