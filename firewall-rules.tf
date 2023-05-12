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