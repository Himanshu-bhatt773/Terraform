# Define required providers
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.48.0"
    }
  }
}

# Configure the OpenStack Provider
provider "openstack" {
  user_name        = "him"
  password         = "Himanshu@098"
  auth_url         = "http://192.168.1.98:5000"
  user_domain_name = "default"
}
