resource "digitalocean_domain" "this" {
  name = var.domain
}

resource "digitalocean_record" "a" {
  for_each = local.a_records
  domain   = digitalocean_domain.this.id
  type     = "A"
  name     = each.value["name"]
  value    = each.value["ip"]
  ttl      = each.value["ttl"]
}

resource "digitalocean_record" "cname" {
  for_each = local.cname_records
  domain   = digitalocean_domain.this.id
  type     = "CNAME"
  name     = each.value["name"]
  value    = endswith(each.value["domain"], ".") ? each.value["domain"] : "${each.value["domain"]}."
  ttl      = each.value["ttl"]
}

resource "digitalocean_record" "mx" {
  for_each = local.mx_records
  domain   = digitalocean_domain.this.id
  type     = "MX"
  name     = each.value["domain"]
  value    = endswith(each.value["hostname"], ".") ? each.value["hostname"] : "${each.value["hostname"]}."
  priority = each.value["priority"]
  ttl      = each.value["ttl"]
}

resource "digitalocean_record" "txt" {
  for_each = local.txt_records
  domain   = digitalocean_domain.this.id
  type     = "TXT"
  name     = each.value["hostname"]
  value    = each.value["txt"]
  ttl      = each.value["ttl"]
}
