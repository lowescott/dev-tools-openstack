# Create a new anti-affinity server group for the Swarm cluster
resource "openstack_compute_servergroup_v2" "swarm" {
	name = "swarm"
	policies = ["anti-affinity"]
}

# Create a new tenant network for the Swarm cluster
resource "openstack_networking_network_v2" "swarm-net" {
	name = "swarm-net"
	admin_state_up = "true"
}

# Create a new subnet and associate it to new Swarm network
resource "openstack_networking_subnet_v2" "swarm-subnet" {
	name = "swarm-subnet"
	network_id = "${openstack_networking_network_v2.swarm-net.id}"
	cidr = "192.168.200.0/24"
	ip_version = 4
	dns_nameservers = ["8.8.8.8","8.8.4.4"]
}

# Create a new router for the Swarm network, attach to external network
resource "openstack_networking_router_v2" "swarm-rtr" {
	name = "swarm-rtr"
	admin_state_up = "true"
	external_gateway = "${var.external_gateway}"
}

# Attach Swarm router to new Swarm network created earlier
resource "openstack_networking_router_interface_v2" "swarm-rtr-if" {
	router_id = "${openstack_networking_router_v2.swarm-rtr.id}"
	subnet_id = "${openstack_networking_subnet_v2.swarm-subnet.id}"
}

# Allocate 5 floating IP addresses for CoreOS instances
resource "openstack_compute_floatingip_v2" "node-01-fip" {
	pool = "${var.pool}"
	depends_on = ["openstack_networking_router_interface_v2.swarm-rtr-if"]
}

resource "openstack_compute_floatingip_v2" "node-02-fip" {
	pool = "${var.pool}"
	depends_on = ["openstack_networking_router_interface_v2.swarm-rtr-if"]
}

resource "openstack_compute_floatingip_v2" "node-03-fip" {
	pool = "${var.pool}"
	depends_on = ["openstack_networking_router_interface_v2.swarm-rtr-if"]
}

resource "openstack_compute_floatingip_v2" "node-04-fip" {
	pool = "${var.pool}"
	depends_on = ["openstack_networking_router_interface_v2.swarm-rtr-if"]
}

resource "openstack_compute_floatingip_v2" "node-05-fip" {
	pool = "${var.pool}"
	depends_on = ["openstack_networking_router_interface_v2.swarm-rtr-if"]
}

# Launch 5 CoreOS instances
resource "openstack_compute_instance_v2" "node-01" {
	name = "node-01"
	image_id = "${var.image}"
	flavor_name = "${var.flavor}"
	key_pair = "${var.key_pair}"
	security_groups = ["default","docker","basic-services","etcd2"]
	floating_ip = "${openstack_compute_floatingip_v2.node-01-fip.address}"
	network {
		uuid = "${openstack_networking_network_v2.swarm-net.id}"
	}
	user_data = "${file(\"cloud-config.yml\")}"
}

resource "openstack_compute_instance_v2" "node-02" {
	name = "node-02"
	image_id = "${var.image}"
	flavor_name = "${var.flavor}"
	key_pair = "${var.key_pair}"
	security_groups = ["default","docker","basic-services","etcd2"]
	floating_ip = "${openstack_compute_floatingip_v2.node-02-fip.address}"
	network {
		uuid = "${openstack_networking_network_v2.swarm-net.id}"
	}
	user_data = "${file(\"cloud-config.yml\")}"
}

resource "openstack_compute_instance_v2" "node-03" {
	name = "node-03"
	image_id = "${var.image}"
	flavor_name = "${var.flavor}"
	key_pair = "${var.key_pair}"
	security_groups = ["default","docker","basic-services","etcd2"]
	floating_ip = "${openstack_compute_floatingip_v2.node-03-fip.address}"
	network {
		uuid = "${openstack_networking_network_v2.swarm-net.id}"
	}
	user_data = "${file(\"cloud-config.yml\")}"
}

resource "openstack_compute_instance_v2" "node-04" {
	name = "node-04"
	image_id = "${var.image}"
	flavor_name = "${var.flavor}"
	key_pair = "${var.key_pair}"
	security_groups = ["default","docker","basic-services","etcd2"]
	floating_ip = "${openstack_compute_floatingip_v2.node-04-fip.address}"
	network {
		uuid = "${openstack_networking_network_v2.swarm-net.id}"
	}
	user_data = "${file(\"cloud-config.yml\")}"
}

resource "openstack_compute_instance_v2" "node-05" {
	name = "node-05"
	image_id = "${var.image}"
	flavor_name = "${var.flavor}"
	key_pair = "${var.key_pair}"
	security_groups = ["default","docker","basic-services","etcd2"]
	floating_ip = "${openstack_compute_floatingip_v2.node-05-fip.address}"
	network {
		uuid = "${openstack_networking_network_v2.swarm-net.id}"
	}
	user_data = "${file(\"cloud-config.yml\")}"
}
