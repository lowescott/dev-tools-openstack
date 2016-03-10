resource "openstack_networking_network_v2" "demo-net" {
	name = "demo-net"
	admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "demo-subnet" {
	name = "demo-subnet"
	network_id = "${openstack_networking_network_v2.tf-net.id}"
	cidr = "192.168.200.0/24"
	ip_version = 4
	dns_nameservers = ["8.8.8.8","8.8.4.4"]
}

resource "openstack_networking_router_v2" "demo-rtr" {
	name = "demo-rtr"
	admin_state_up = "true"
	external_gateway = "${var.external_gateway}"
}

resource "openstack_networking_router_interface_v2" "demo-rtr-if" {
	router_id = "${openstack_networking_router_v2.demo-rtr.id}"
	subnet_id = "${openstack_networking_subnet_v2.demo-subnet.id}"
}

resource "openstack_networking_floatingip_v2" "demo-fip" {
	pool = "${var.pool}"
	depends_on = ["openstack_networking_router_interface_v2.demo-rtr-if"]
}

resource "openstack_compute_instance_v2" "demo-instance" {
	name = "demo-instance"
	image_name = "${var.image}"
	flavor_name = "${var.flavor}"
	key_pair = "${var.key_pair}"
	security_groups = ["default"]
	floating_ip = "${openstack_networking_floatingip_v2.demo-fip.address}"
	network {
		uuid = "${openstack_networking_network_v2.demo-net.id}"
	}
}
