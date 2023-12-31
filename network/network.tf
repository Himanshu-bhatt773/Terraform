resource "openstack_networking_router_v2" "router_1" {
  name                = var.router_name
  admin_state_up      = true
  external_network_id = var.ext_net_id
}


resource "openstack_networking_network_v2" "network_1" {
  name           = var.int_net_name
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name            = var.int_sub_name
  network_id      = openstack_networking_network_v2.network_1.id
  cidr            = var.int_sub_cidr
  ip_version      = 4
  gateway_ip      = var.int_sub_gateway
  dns_nameservers = ["8.8.8.8"]
}

resource "openstack_networking_router_interface_v2" "router_interface_2" {
  router_id = openstack_networking_router_v2.router_1.id
  subnet_id = openstack_networking_subnet_v2.subnet_1.id
}
