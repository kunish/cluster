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

resource "helm_release" "nfs-subdir-external-provisioner" {
  name              = "nfs-subdir-external-provisioner"
  repository        = "https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner"
  chart             = "nfs-subdir-external-provisioner"
  namespace         = "nfs-subdir-external-provisioner"
  create_namespace  = true
  dependency_update = true
  values            = [file("values/nfs-subdir-external-provisioner.yml")]
}

resource "helm_release" "prometheus" {
  name              = "prometheus"
  repository        = "https://prometheus-community.github.io/helm-charts"
  chart             = "prometheus"
  namespace         = "prometheus"
  create_namespace  = true
  dependency_update = true
  depends_on = [
    helm_release.nfs-subdir-external-provisioner
  ]
}

resource "helm_release" "metallb" {
  name              = "metallb"
  repository        = "https://metallb.github.io/metallb"
  chart             = "metallb"
  namespace         = "metallb-system"
  create_namespace  = true
  dependency_update = true
  values            = [file("values/metallb.yml")]
}

resource "helm_release" "ingress-nginx" {
  name              = "ingress-nginx"
  repository        = "https://kubernetes.github.io/ingress-nginx"
  chart             = "ingress-nginx"
  namespace         = "ingress-nginx"
  create_namespace  = true
  dependency_update = true
  values            = [file("values/ingress-nginx.yml")]
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
  values            = [file("values/external-dns.yml")]
}

resource "helm_release" "cert-manager" {
  name              = "cert-manager"
  repository        = "https://charts.jetstack.io"
  chart             = "cert-manager"
  namespace         = "cert-manager"
  create_namespace  = true
  dependency_update = true
  values            = [file("values/cert-manager.yml")]
  depends_on = [
    helm_release.nfs-subdir-external-provisioner
  ]
}

resource "helm_release" "sealed-secrets" {
  name              = "sealed-secrets"
  repository        = "https://bitnami-labs.github.io/sealed-secrets"
  chart             = "sealed-secrets"
  namespace         = "kube-system"
  create_namespace  = true
  dependency_update = true
}

resource "helm_release" "argo-cd" {
  name              = "argo-cd"
  repository        = "https://argoproj.github.io/argo-helm"
  chart             = "argo-cd"
  namespace         = "argo-cd"
  create_namespace  = true
  dependency_update = true
  values            = [file("values/argo-cd.yml")]
  depends_on = [
    helm_release.ingress-nginx,
  ]
}

resource "helm_release" "keel" {
  name              = "keel"
  repository        = "https://charts.keel.sh"
  chart             = "keel"
  namespace         = "kube-system"
  create_namespace  = true
  dependency_update = true
}

resource "helm_release" "gitlab" {
  name              = "gitlab"
  repository        = "https://charts.gitlab.io"
  chart             = "gitlab"
  namespace         = "gitlab"
  create_namespace  = true
  dependency_update = true
  values            = [file("values/gitlab.yml")]
  depends_on = [
    helm_release.cert-manager,
    helm_release.ingress-nginx,
    helm_release.nfs-subdir-external-provisioner,
  ]
}
