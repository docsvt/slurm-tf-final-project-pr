resource "yandex_alb_backend_group" "this" {
  name      = "${local.prefix}-alb-backend-group"

  http_backend {
    name = "${local.prefix}-http-backend"
    weight = 1
    port = 80
    target_group_ids = ["${yandex_compute_instance_group.this.application_load_balancer[0].target_group_id}"]
    load_balancing_config {
      panic_threshold = 50
    }    
    healthcheck { # to variable
      timeout = "1s"
      interval = "1s"
      http_healthcheck {
        path  = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "this" {
  name      = "${local.prefix}-nginx-http-router"
  labels = var.labels
}

resource "yandex_alb_virtual_host" "this" {
  name           = "${local.prefix}-vhost"
  http_router_id = yandex_alb_http_router.this.id
  route {
    name = "${local.prefix}-route"
    http_route {
      http_route_action {
        backend_group_id = "${yandex_alb_backend_group.this.id}"
        timeout          = "60s"
      }
    }
  }
}   

resource "yandex_alb_load_balancer" "this" {
  name = "${local.prefix}-lb"

  labels = var.labels
  
  network_id = "${yandex_vpc_network.this.id}"
  
  allocation_policy {
    dynamic "location" {
      for_each = toset(var.yc_zones)
      content { 
        zone_id   = location.key
        subnet_id = yandex_vpc_subnet.this[location.key].id
      }
    }
  }

  listener {
    name = "${local.prefix}-alb-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }    
    http {
      handler {
        http_router_id = yandex_alb_http_router.this.id
      }
    }
  }
}
