releases = {
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
  "longhorn" = {
    repository       = "https://charts.longhorn.io"
    chart            = "longhorn"
    namespace        = "longhorn-system"
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
  "prometheus" = {
    repository       = "https://prometheus-community.github.io/helm-charts"
    chart            = "prometheus"
    namespace        = "prometheus"
    create_namespace = true
    values           = []
  }
  "argo-cd" = {
    repository       = "https://argoproj.github.io/argo-helm"
    chart            = "argo-cd"
    namespace        = "argo-cd"
    create_namespace = true
    values           = ["helm/argo-cd/values.yml"]
  }
}
