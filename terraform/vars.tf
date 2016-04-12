# Image ID for CoreOS Stable 899.13.0 image
variable "image" {
    default = "6ebd5b1e-f5d5-4bf7-9ca8-713a2696307f"
}

# Default flavor to use for CoreOS instances
variable "flavor" {
	default = "m1.small"
}

# Network ID for external network to which new router will be connected
variable "external_gateway" {
	default = "c924f32c-a583-4b6a-af23-62746790a205"
}

# SSH keypair to be injected into new instances
variable "key_pair" {
	default = "lab"
}

# Network name for floating IP addresses (must correspond to external_gateway)
variable "pool" {
	default = "ext-net-5"
}
