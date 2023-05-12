
/*# https://wireguard.how/server/google-cloud-platform/

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
*/
/*
# Create firewall rule for Wireguard
resource "google_compute_firewall" "wg-rule" {
  project = var.projejctid
  name    = "tanzu-wireguard"
  network = google_compute_network.vpc.name
  allow {
    protocol = "udp"
    ports    = ["51820"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# Create firewall rule for icmp
resource "google_compute_firewall" "tanzu-icmp" {
  project = var.projejctid
  name    = "tanzu-icmp"
  network = google_compute_network.vpc.name
  #subnetwork = google_compute_subnetwork.subnet.id
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}

# Create firewall rule for Wireguard DEVELOPMENT disable when ready
resource "google_compute_firewall" "ssh-rule" {
  project = var.projejctid
  name    = "tanzu-ssh"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}
*/
## Create IP address for Wireguard VM
resource "google_compute_address" "static" {
  name         = "wireguard-ip"
  description  = "External address for WireGuard"
}

#Create the Wireguard VM
resource "google_compute_instance" "wireguard-vm" {
  project      = var.projejctid
  zone         = var.zone
  name         = "wireguard"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  can_ip_forward = true
  metadata_startup_script = templatefile("./template.tftpl", {wgip = var.wgip})
}

#Create the test VM
resource "google_compute_instance" "test-vm" {
  project      = var.projejctid
  zone         = var.zone
  name         = "test"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.id
  }
}
