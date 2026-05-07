variable "instance_name" {
  description = "The name of the VM instance"
  type        = string
  default     = "basic-vm"
}

variable "machine_type" {
  description = "The machine type to create"
  type        = string
  default     = "e2-medium"
}

variable "zone" {
  description = "The zone that the machine should be created in"
  type        = string
  default     = "us-central1-a"
}

variable "image" {
  description = "The image from which to initialize this disk"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "network" {
  description = "The name or self_link of the network to attach this interface to"
  type        = string
  default     = "default"
}
