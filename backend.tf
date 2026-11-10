# O nome do bucket não fica no código: é informado no terraform init
# (veja o README, seção "Configuração").
terraform {
  backend "s3" {
    key          = "site2/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true
  }
}
