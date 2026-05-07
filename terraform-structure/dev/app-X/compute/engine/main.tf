module "app_x_compute_engine" {
  source = "../../../../modules/compute/engine"

  instance_name = "app-x-instance"
  machine_type  = "e2-medium"
  zone          = "us-central1-a"
  # network     = "default"
  # image       = "debian-cloud/debian-11"
}
