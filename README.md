# Deploy test app into eks with terraform, AWS, eks, helm

# create-simple-terraform

Terraform manifest to deploy a simple app into web with AWS eks, ingress, helm


## Requirements

1. [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)
2. [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Installation


```bash
terraform init
terraform plan
terraform apply
```

## Content

```bash
.
├── app (app helm manifest)
│   ├── Chart.yaml
│   ├── content (app content)
│   │   └── index.php
│   ├── templates
│   │   ├── _helpers.tpl
│   │   ├── configmap.yaml
│   │   ├── deployment.yaml
│   │   ├── ingress.yaml
│   │   └── service.yaml
│   └── values.yaml
├── app.tf (app terraform manifest)
├── var.tf (manifest vars)

```