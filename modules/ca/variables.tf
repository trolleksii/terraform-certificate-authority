variable "create_ca" {
  type        = bool
  description = "When set to `true` CA certificate and private key will be generated. When set to `false`, path to certificate and private key must be set with `ca_cert_file` and `ca_pkey_file`. Defaults to `false`"
  default     = false
}

variable "ca_cert_file" {
  type        = string
  description = "Wneh `create_ca` is false, the absolute or relative path to the CA certificate file. Defaults to `ca/ca.crt`."
  default     = "ca/ca.crt"
}

variable "ca_pkey_file" {
  type        = string
  description = "Wneh `create_ca` is false, the absolute or relative path to the CA private key file. Defaults to `ca/ca.key`."
  default     = "ca/ca.key"
}

variable "ca_key_algorithm" {
  type        = string
  description = "The name of the algorithm to use for the key. Currently-supported values are `RSA` and `ECDSA`. Defaults to `RSA`."
  default     = "RSA"
}

variable "ca_key_rsa_bits" {
  type        = number
  description = "When algorithm is `RSA`, the size of the generated RSA key in bits. Defaults to 2048."
  default     = 2048
}

variable "client_key_algorithm" {
  type        = string
  description = "The name of the algorithm to use for the key. Currently-supported values are `RSA` and `ECDSA`. Defaults to `RSA`."
  default     = "RSA"
}

variable "client_key_rsa_bits" {
  type        = number
  description = "When algorithm is `RSA`, the size of the generated RSA key in bits. Defaults to 2048."
  default     = 2048
}

variable "ca_key_ecdsa_curve" {
  type        = string
  description = "When algorithm is `ECDSA`, the name of the elliptic curve to use. May be any one of `P224`, `P256`, `P384` or `P521`, with `P224` as the default."
  default     = "P224"
}

variable "ca_cert_validity_period" {
  type        = number
  description = "The number of hours after initial issuing that the certificate will become invalid. Defaults to 26280."
  default     = 26280
}

variable "ca_cert_early_renewal_hours" {
  type        = number
  description = "If set, the resource will consider the certificate to have expired the given number of hours before its actual expiry time. Defaults to 8760."
  default     = 8760
}

variable "ca_cert_subject" {
  description = "The subject for which a certificate is being requested."
}

variable "client_key_ecdsa_curve" {
  type        = string
  description = "When algorithm is `ECDSA`, the name of the elliptic curve to use. May be any one of `P224`, `P256`, `P384` or `P521`, with `P224` as the default."
  default     = "P224"
}

variable "client_cert_subjects" {
  description = "The subject for which a certificate is being requested."
}

variable "client_cert_validity_period" {
  type        = number
  description = "The number of hours after initial issuing that the certificate will become invalid. Defaults to 17520."
  default     = 17520
}

variable "client_cert_early_renewal_hours" {
  type        = number
  description = "If set, the resource will consider the certificate to have expired the given number of hours before its actual expiry time. Defaults to 8760."
  default     = 8760
}

