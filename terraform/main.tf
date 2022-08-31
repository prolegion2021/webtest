provider "google" {
  credentials = file("gcp_api.json") # шлях до GCP credentials
  project = "atlantean-site-356907"
  region = "europe-north1"
  zone = "europe-north1-a"
}

resource "google_compute_instance" "webserver" {
  name         = "webserver"
  machine_type = "e2-medium"
  zone         = "europe-north1-a"
  metadata_startup_script = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
EOF
  metadata = {
   ssh-keys = "prolegion:${file("/home/prolegion/Documents/terraform/ssh/gcp_vm.pub")}"
 }
  boot_disk {
    initialize_params {
      image = "debian-11"
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
}
