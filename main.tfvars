create_ca = true

ca_cert_subject = {
  common_name         = "Trollab Root CA"
  organization        = "Trollab"
  street_address      = ["309-3089 Jaguar Valley Drive"]
  locality            = "Mississauga"
  province            = "ON"
  country             = "CA"
  postal_code         = "L5A-2J1"
  serial_number       = 1001
}

client_cert_subjects = [
  {
    common_name         = "laptop.trollab.ca"
    alternative_names   = ["laptop.trollab.ca"]
    organization        = "Trollab"
    organizational_unit = "DevOps"
    street_address      = ["309-3089 Jaguar Valley Drive"]
    locality            = "Mississauga"
    province            = "ON"
    country             = "CA"
    postal_code         = "L5A-2J1"
    serial_number       = 1004
  }
]
