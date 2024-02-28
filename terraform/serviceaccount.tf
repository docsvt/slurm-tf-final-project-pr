# Creating a service account and assigning bindings

resource "yandex_iam_service_account" "this" {
  name = "${local.prefix}-autoscale"
}

resource "yandex_resourcemanager_folder_iam_binding" "this" {
  folder_id = data.yandex_resourcemanager_folder.this.folder_id
  role = "editor"
  members = [ 
    "serviceAccount:${yandex_iam_service_account.this.id}", 
    ]
}
