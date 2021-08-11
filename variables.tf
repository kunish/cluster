variable "releases" {
  type = map(object({
    repository       = string
    chart            = string
    namespace        = string
    create_namespace = bool
    values           = list(string)
  }))
}
