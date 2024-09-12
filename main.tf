terraform {
  // Terraform block to specify required providers
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.26.1"  // Version constraint for Docker provider
    }
  }
}

provider "docker" {} // Docker provider block

resource "docker_image" "nginx" { // Resource block to define Docker image
  name         = "nginx:latest"  // Image name
  keep_locally = false           // Do not keep the image locally
}

resource "docker_container" "nginx" { // Resource block to define Docker container
  image = docker_image.nginx.image_id  // Reference the image_id from the docker_image resource
  name  = "nginx-tf"                   // Container name
  
  ports {  // Port mapping
    internal = 80   // Internal port
    external = 8000 // External port
  }
}

