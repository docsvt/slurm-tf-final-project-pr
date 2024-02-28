# Создание целевого образа centos с установленным nginx в Yandex Cloud

Образ создается развертыванием  стандартного образа centos 7 с последующим применением локальной роли ansible

Сборка выполняется командным файлом packer_build.sh

## Условия выполнения

Должны быть установлены переменные окружения для доступа к Ynadex Cloud

- YC_TOKEN=$(yc iam create-token)
- YC_CLOUD_ID=$(yc config get cloud-id)

Перед первым выполнение необходимо выполнить инициализацию packer 

```shell
packer init config.pkr.hcl
```

## Параметры 

Параметры сборки передаются через переменные окружения

- YC_FOLDER - имя каталога Yandex Cloud, по умолчанию default
- YC_IMAGE_BASE_NAME - базовое имя образа, по умолчанию nginx
- YC_IMAGE_TAG - тэг создаваемого образа, по умолчанию 202402
- YC_IMAGE_ZONE -  зона Yandex Cloud, в которой выполняется создание образа, по умолчанию ru-central1-a
- YC_IMAGE_SUBNET - подсесть, используемая для создания образа, по умолчанию default-ru-central1-a

или через параметры вызова packer_build.sh

- --image-base-name - базовое имя образа, по умолчанию nginx
- --image-tag - тэг создаваемого образа, по умолчанию 202402
- --folder - имя каталога Yandex Cloud, по умолчанию default
- --subnet - подсесть, используемая для создания образа, по умолчанию default-ru-central1-a
- --zone - зона Yandex Cloud, в которой выполняется создание образа, по умолчанию ru-central1-a

## Запуск 

```bash
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
./packer_build.sh

```

```bash
YC_TOKEN=$(yc iam create-token) \
YC_CLOUD_ID=$(yc config get cloud-id) \
./packer_build.sh --image-base-name nginx --image-tag 20240225

```
