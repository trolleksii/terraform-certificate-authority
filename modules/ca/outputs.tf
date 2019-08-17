output "ca_cert" {
  value = tls_self_signed_cert.root.0.cert_pem
}

output "ca_pkey" {
  value = tls_private_key.root.0.private_key_pem
}

output "client_cert" {
  value = tls_locally_signed_cert.client.*.cert_pem
}

output "client_private_key" {
  value = tls_private_key.client.*.private_key_pem
}

