output "instance_id" {
  description = "The server-assigned unique identifier of this instance."
  value       = google_compute_instance.vm_instance.id
}

output "instance_ip" {
  description = "The external IP assigned to the instance."
  value       = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}
