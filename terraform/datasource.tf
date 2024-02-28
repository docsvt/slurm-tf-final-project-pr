data "yandex_compute_image" "this" {
  name = "${var.image_base_name}-${var.image_tag}"
  folder_id = data.yandex_resourcemanager_folder.this.id
}

data "yandex_resourcemanager_folder" "this" {
    name = var.yc_resource_folder
}
