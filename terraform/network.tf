resource "yandex_vpc_network" "this" {
  name   = "${local.prefix}-network"
  labels = var.labels
}

resource "yandex_vpc_subnet" "this" {
  for_each       = toset(var.yc_zones)
  name           = "${local.prefix}-${each.value}"
  v4_cidr_blocks = var.cidr_blocks[index(var.yc_zones, each.value)]
  network_id     = yandex_vpc_network.this.id
  zone           = each.value
  labels         = var.labels
}
