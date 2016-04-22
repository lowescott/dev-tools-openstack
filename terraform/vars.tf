# Image ID for CoreOS Stable 899.13.0 image
variable "image" {
    default = "6108ff8f-8cd5-447d-898b-b67bdc3eee17"
}

# Default flavor to use for CoreOS instances
variable "flavor" {
	default = "m1.small"
}

# Network ID for external network to which new router will be connected
variable "external_gateway" {
	default = "e7ef060a-5ff9-4148-8a38-993951ed9da9"
}

# SSH keypair to be injected into new instances
variable "key_pair" {
	default = "aws"
}

# Network name for floating IP addresses (must correspond to external_gateway)
variable "pool" {
	default = "EXTNET"
}
