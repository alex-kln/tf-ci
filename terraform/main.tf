terraform {
  required_version = ">= 1.1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.59.0"
    }
  }
}

provider "google" {
  project = "spry-root-277213"
  region  = "europe-west3"
}

resource "google_pubsub_topic" "example_resource" {
  name = var.topic_name
}
