#!/usr/bin/env bash 

export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

export TF_VAR_image_tag=${TF_VAR_image_tag:=20240225}
export TF_VAR_image_base_name=${TF_VAR_image_base_name:=nginx}
