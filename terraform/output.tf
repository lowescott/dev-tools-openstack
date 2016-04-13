# Output the floating IP addresses allocated to the CoreOS instances
output "address" {
	value = "${openstack_compute_floatingip_v2.node-01-fip.address}"
}

output "address" {
    value = "${openstack_compute_floatingip_v2.node-02-fip.address}"
}

output "address" {
    value = "${openstack_compute_floatingip_v2.node-03-fip.address}"
}

output "address" {
    value = "${openstack_compute_floatingip_v2.node-04-fip.address}"
}

output "address" {
    value = "${openstack_compute_floatingip_v2.node-05-fip.address}"
}
