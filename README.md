# Local Certificate Authority

Script will create Certificate Authority with self-sighed key, and sign one or more x.509 certificates.

To create a new CA, create variables file with subject description:

```RUBY
create_ca       = true
ca_cert_subject = {
    common_name         = "example.com"
    organization        = "My org"
    organizational_unit = "Org department"
    street_address      = ["1 Dundas str"]
    locality            = "Toronto"
    province            = "ON"
    country             = "CA"
    postal_code         = "111-222"
    serial_number       = null
}
```

you can also add optional `client_cert_subjects` variable with a list of subjects for certificates issue:

```RUBY
client_cert_subjects = [{
  common_name         = "website.local"
  organization        = "My org"
  organizational_unit = "Org unit"
  street_address      = ["Some address"]
  locality            = "Toronto"
  province            = "ON"
  country             = "CA"
  postal_code         = "112-221"
  serial_number       = null
},
{
  common_name         = "localhost"
  organization        = "My org"
  organizational_unit = "Org unit"
  street_address      = ["Some address"]
  locality            = "Toronto"
  province            = "ON"
  country             = "CA"
  postal_code         = "112-221"
  serial_number       = null
}]
```

## How to reuse CA created earlier

You can skip CA creation and consume certificate and key created by this script earlier by setting

```RUBY
create_ca = false
```

and specifying path to the certificate and the private key

```RUBY
ca_cert_file = "ca.crt"
ca_pkey_file = "ca.key"
```

There are number of additional options you can set, please refer to the *variables.tf* file for complete list.

## Run it

Assuming that variables are in *main.tfvars* file

```
terraform init
terraform plan -input=false -no-color -var-file=main.tfvars -out=main.tfplan && terraform apply main.tfplan
```
