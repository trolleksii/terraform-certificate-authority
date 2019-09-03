resource "tls_private_key" "root" {
  count       = var.create_ca == true ? 1 : 0
  algorithm   = var.ca_key_algorithm
  rsa_bits    = var.ca_key_algorithm == "RSA" ? var.ca_key_rsa_bits : null
  ecdsa_curve = var.ca_key_algorithm == "RSA" ? null: var.ca_key_ecdsa_curve
}

resource "tls_self_signed_cert" "root" {
  count = var.create_ca == true ? 1 : 0
  key_algorithm         = tls_private_key.root.0.algorithm
  private_key_pem       = tls_private_key.root.0.private_key_pem
  validity_period_hours = var.ca_cert_validity_period
  early_renewal_hours   = var.ca_cert_early_renewal_hours
  is_ca_certificate     = true
  allowed_uses          = ["cert_signing"]
  subject {
    common_name         = lookup(var.ca_cert_subject, "common_name", null)
    country             = lookup(var.ca_cert_subject, "country", null)
    locality            = lookup(var.ca_cert_subject, "locality", null)
    organization        = lookup(var.ca_cert_subject, "organization", null)
    organizational_unit = lookup(var.ca_cert_subject, "organizational_unit", null)
    postal_code         = lookup(var.ca_cert_subject, "postal_code", null)
    province            = lookup(var.ca_cert_subject, "province", null)
    serial_number       = lookup(var.ca_cert_subject, "serial_number", null)
    street_address      = lookup(var.ca_cert_subject, "street_address", null)
  }
}

resource "tls_private_key" "client" {
  count       = length(var.client_cert_subjects)
  algorithm   = var.client_key_algorithm
  rsa_bits    = var.client_key_algorithm == "RSA" ? var.client_key_rsa_bits : null
  ecdsa_curve = var.client_key_algorithm == "RSA" ? null: var.client_key_ecdsa_curve
}

resource "tls_cert_request" "client" {
  count           = length(var.client_cert_subjects)
  key_algorithm   = tls_private_key.client[count.index].algorithm
  private_key_pem = tls_private_key.client[count.index].private_key_pem
  dns_names       = lookup(var.client_cert_subjects[count.index], "alternative_names", null)
  subject {
    common_name         = lookup(var.client_cert_subjects[count.index], "common_name", null)
    country             = lookup(var.client_cert_subjects[count.index], "country", null)
    locality            = lookup(var.client_cert_subjects[count.index], "locality", null)
    organization        = lookup(var.client_cert_subjects[count.index], "organization", null)
    organizational_unit = lookup(var.client_cert_subjects[count.index], "organizational_unit", null)
    postal_code         = lookup(var.client_cert_subjects[count.index], "postal_code", null)
    province            = lookup(var.client_cert_subjects[count.index], "province", null)
    serial_number       = lookup(var.client_cert_subjects[count.index], "serial_number", null)
    street_address      = lookup(var.client_cert_subjects[count.index], "street_address", null)
  }
}

resource "tls_locally_signed_cert" "client" {
  count              = length(var.client_cert_subjects)
  cert_request_pem   = tls_cert_request.client[count.index].cert_request_pem

  ca_key_algorithm   = var.create_ca == true ? tls_private_key.root.0.algorithm : var.ca_key_algorithm
  ca_private_key_pem = var.create_ca == true ? tls_private_key.root.0.private_key_pem : file(var.ca_pkey_file)

  ca_cert_pem        = var.create_ca == true ? tls_self_signed_cert.root.0.cert_pem : file(var.ca_cert_file)

  validity_period_hours = var.client_cert_validity_period
  early_renewal_hours   = var.client_cert_early_renewal_hours

  allowed_uses = [
    "server_auth",
    "client_auth"
  ]
}
