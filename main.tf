module "ca" {
  source                          = "./modules/ca"
  create_ca                       = var.create_ca
  ca_cert_file                    = var.ca_cert_file
  ca_pkey_file                    = var.ca_pkey_file
  ca_key_algorithm                = var.ca_key_algorithm
  ca_key_rsa_bits                 = var.ca_key_rsa_bits
  ca_key_ecdsa_curve              = var.ca_key_ecdsa_curve
  client_key_algorithm            = var.client_key_algorithm
  client_key_ecdsa_curve          = var.client_key_ecdsa_curve
  ca_cert_validity_period         = var.ca_cert_validity_period
  ca_cert_early_renewal_hours     = var.ca_cert_early_renewal_hours
  ca_cert_subject                 = var.ca_cert_subject
  client_cert_validity_period     = var.client_cert_validity_period
  client_cert_early_renewal_hours = var.client_cert_early_renewal_hours
  client_cert_subjects            = var.client_cert_subjects
}

locals {
  client = [for i in range(length(var.client_cert_subjects)) : {
    name = replace(var.client_cert_subjects[i]["common_name"], "*", "all")
    cert = module.ca.client_cert[i],
    pkey = module.ca.client_private_key[i]
  }]
}

resource "local_file" "ca_cert" {
  count    = var.create_ca == true ? 1 : 0
  content  = module.ca.ca_cert
  filename = "${path.module}/ca.crt"
}

resource "local_file" "ca_pkey" {
  count    = var.create_ca == true ? 1 : 0
  content  = module.ca.ca_pkey
  filename = "${path.module}/ca.key"
}

resource "local_file" "client_certs" {
  count    = length(var.client_cert_subjects)
  content  = local.client[count.index].cert
  filename = "${path.module}/${local.client[count.index].name}.crt"
}

resource "local_file" "client_pkeys" {
  count    = length(var.client_cert_subjects)
  content  = local.client[count.index].pkey
  filename = "${path.module}/${local.client[count.index].name}.key"
}
