# Terraform
create internal network 
```
cd network/
terraform init
terraform validate
terraform plan
terraform apply
```

#### create instance 
```
cd ..
cat terraform.tfvars  ####### change variable accordingly
image_name    = "cirros"
flavor_name   = "mi.yint"
instance_name = "test1"
keypair_name  = "test"
network       = "init_net"
secgroup_name = "allow_ssh"


##### add security rules

cat sec_grp.tf 
resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = var.secgroup_name 
  description = "My neutron security group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = port
  port_range_max    = port
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}
..............

terraform init
terraform plan
terraform apply
```


