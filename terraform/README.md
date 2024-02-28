# Развертывания инфраструктуры в Yandex Cloud с целевого образа 

Инфраструктура развертывается из целевого образа как compute instance group c автоматическим масштабированием
и application load balancer

Развертывание выполняется командой  terraform apply

Размер развертывания регулируется параметрами: 

 - yc_min_zone_size и количеством зон yc_zones - количество первично развертываемых ВМ определяется как yc_min_zone_size * length(yc_zones)
 - vm_resources - ресурсные параметры ВМ: cores, memory, disk
 - yc_max_group_size - максимальный размер группы

# Ограничения

 1. Для VM используется предустановленный в packer пользователь centos
 2. VM создаются NAT для сетевого интерфейса

## Условия выполнения

Должны быть установлены переменные окружения для доступа к Ynadex Cloud

- YC_TOKEN=$(yc iam create-token)
- YC_CLOUD_ID=$(yc config get cloud-id)

Перед первым выполнение необходимо выполнить инициализацию terraform

```shell
terraform init 
```

## Параметры 

Параметры развертывания (переменные terraform)

 - yc_resource_folder  - Resource manager folder for instance group, по умолчанию *default*
 - image_base_name  - базове имя образа, по умолчанию *nginx*
 - image_tag - тэг базового образа, обязательный параметр
 - cidr_blocks - список IP-адресация для создаваемых подсетей, обязательный параметр, количество должно совпадать с количеством зон, по умолчанию *[["10.10.0.0/24"],["10.20.0.0/24"],["10.30.0.0/24"],]*
 - labels - метки для создаваемых ресурсов, по умолчанию *{}*
 - yc_zones - перечень зон развертывания, по умолчанию *["ru-central1-a","ru-central1-b","ru-central1-d"]*
 - public_ssh_key_path - путь к публичному ssh ключу, который будет установлен для создаваемых ВМ, по умолчанию генеририруется в  процессе развертывания 
 - private_ssh_key_path - путь к приватному ssh ключу, который будет установлен для создаваемых ВМ, по умолчанию генеририруется в процессе развертывания
 - alb_healthcheck тест доступности сервиса, по умолчанию *{name = "test", port = 80,  path = "/"}*
 - yc_max_group_size максимальный размер instance group, по умолчанию *3*, рекомендуется кратным количеству зон развертывания
 - yc_min_zone_size - минимальное количество ВМ для каждой зоны развертывания, по умолчанию *1*, количество первично развертываемых ВМ определяется как yc_min_zone_size * length(yc_zones)
 - vm_resources - ресурсные параметры ВМ: cores, memory, disk, по умолчанию *{cores = 2,memory = 4,disk = 10}*
  
## Запуск 

```bash
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
terraform apply --auto-approve --var image_tag=20240225

```

```bash
YC_TOKEN=$(yc iam create-token) \
YC_CLOUD_ID=$(yc config get cloud-id) \
terraform apply --var image_tag=20240225 --var image_base_name=nginx

```

# Вывод

 - external_alb_ip - внешний адрес балансировщика
 - vm_external_ip  - внешние адрес развертываемых VM
 - vm_ssh_key  - приватный SSH ключ для развертываемых VM
