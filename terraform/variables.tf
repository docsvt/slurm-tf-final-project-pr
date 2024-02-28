variable "yc_resource_folder" {
  type        = string
  description = "Resource manager folder for instance group"
  default     = "default"
}

variable "image_base_name" {
  type        = string
  description = "Name used image"
  default     = "nginx"
}

variable "image_tag" {
  type        = string
  description = "Tag for group image"
}

variable "cidr_blocks" {
  type        = list(list(string))
  description = "List of IPv4 cidr blocks for subnet"
  default = [
    ["10.10.0.0/24"],
    ["10.20.0.0/24"],
    ["10.30.0.0/24"],
  ]

}

variable "labels" {
  type        = map(string)
  description = "Labels to add to resources"
  default     = {}
}

variable "yc_zones" {
  type        = list(string)
  description = "Yandex cloud zone mapping"
  default = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-d"
  ]
}

variable "public_ssh_key_path" {
  type        = string
  description = "ssh public key path"
  default     = ""
}

variable "private_ssh_key_path" {
  type        = string
  description = "ssh private key path"
  default     = ""
}

variable "alb_healthcheck" {
  type = object(
    {
      name = string
      port = number
      path = string
    }
  )

  description = "Load balancer healthcheck"
  default = {
    name = "test"
    port = 80
    path = "/"
  }
}

variable "yc_max_group_size" {
  type        = number
  description = "Maximum deployment size"
  default     = 3
}


variable "yc_min_zone_size" {
  type        = number
  description = "Minimal vm in every availability zone"
  default     = 1
}


variable "vm_resources" {
  type = object({
    cores  = number,
    memory = number,
    disk   = number
  })
  description = "VM resources"
  default = {
    cores  = 2,
    memory = 4,
    disk   = 10
  }
}
