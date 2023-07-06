data "openstack_images_image_v2" "image" {
  name        = var.image_name # Name of image to be used
  most_recent = true
}

# get keypair

resource "openstack_compute_keypair_v2" "keypair" {
  name       = var.keypair_name
  public_key = file("${path.module}/id_rsa.pub")
}


## Get flavor id
data "openstack_compute_flavor_v2" "flavor" {
  name = var.flavor_name # flavor to be used
}

# Create an instance
resource "openstack_compute_instance_v2" "server" {
  name            = var.instance_name #Instance name
  image_id        = data.openstack_images_image_v2.image.id
  flavor_id       = data.openstack_compute_flavor_v2.flavor.id
  key_pair        = var.keypair_name
  security_groups = ["${openstack_networking_secgroup_v2.secgroup_1.name}"]

  network {
    name = var.network
  }
}

# Add Floating ip
resource "openstack_networking_floatingip_v2" "fip1" {
  pool = "public"
}

resource "openstack_compute_floatingip_associate_v2" "fip1" {
  floating_ip = openstack_networking_floatingip_v2.fip1.address
  instance_id = openstack_compute_instance_v2.server.id
}

# Output VM IP Addresses
output "server_private_ip" {
  value = openstack_compute_instance_v2.server.access_ip_v4
}
output "server_floating_ip" {
  value = openstack_networking_floatingip_v2.fip1.address
}
