terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.8.0"
    }
  }
}

provider "google" {
  credentials = file("../pa-nteekens-2-87ca54069ac2.json")
  project     = "pa-nteekens-2"
  region      = "europe-west4"
  zone        = "europe-west4-a"
}