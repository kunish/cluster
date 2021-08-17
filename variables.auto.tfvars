releases = {
  "longhorn" = {
    repository       = "https://charts.longhorn.io"
    chart            = "longhorn"
    namespace        = "longhorn-system"
    create_namespace = true
    values           = []
  }
  "prometheus" = {
    repository       = "https://prometheus-community.github.io/helm-charts"
    chart            = "prometheus"
    namespace        = "prometheus"
    create_namespace = true
    values           = []
  }
  "metallb" = {
    repository       = "https://metallb.github.io/metallb"
    chart            = "metallb"
    namespace        = "metallb-system"
    create_namespace = true
    values           = ["helm/metallb/values.yml"]
  }
  "ingress-nginx" = {
    repository       = "https://kubernetes.github.io/ingress-nginx"
    chart            = "ingress-nginx"
    namespace        = "ingress-nginx"
    create_namespace = true
    values           = []
  }
  "external-dns" = {
    repository       = "https://charts.bitnami.com/bitnami"
    chart            = "external-dns"
    namespace        = "external-dns"
    create_namespace = true
    values           = ["helm/external-dns/values.yml"]
  }
  "cert-manager" = {
    repository       = "https://charts.jetstack.io"
    chart            = "cert-manager"
    namespace        = "cert-manager"
    create_namespace = true
    values           = ["helm/cert-manager/values.yml"]
  }
  "kubernetes-dashboard" = {
    repository       = "https://kubernetes.github.io/dashboard"
    chart            = "kubernetes-dashboard"
    namespace        = "kubernetes-dashboard"
    create_namespace = true
    values           = ["helm/kubernetes-dashboard/values.yml"]
  }
  "argo-cd" = {
    repository       = "https://argoproj.github.io/argo-helm"
    chart            = "argo-cd"
    namespace        = "argo-cd"
    create_namespace = true
    values           = ["helm/argo-cd/values.yml"]
  }
  "rancher" = {
    repository       = "https://releases.rancher.com/server-charts/latest"
    chart            = "rancher"
    namespace        = "cattle-system"
    create_namespace = true
    values           = ["helm/rancher/values.yml"]
  }
  "wordpress" = {
    repository       = "https://charts.bitnami.com/bitnami"
    chart            = "wordpress"
    namespace        = "apps"
    create_namespace = true
    values           = ["helm/wordpress/values.yml"]
  }
  "ghost" = {
    repository       = "https://charts.bitnami.com/bitnami"
    chart            = "ghost"
    namespace        = "apps"
    create_namespace = true
    values           = ["helm/ghost/values.yml"]
  }
}
