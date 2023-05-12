# create VPC 
resource "google_compute_network" "vpc" {
  name                    = var.vpcname
  auto_create_subnetworks = false
}

# Create Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnetname
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.subnetcidr
}
