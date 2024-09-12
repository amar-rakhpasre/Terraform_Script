# Nginx Deployment with Docker and Terraform

This guide provides a step-by-step instruction to deploy an Nginx web server using Docker and Terraform. Follow the instructions below to set up the environment and deploy the project.

## Prerequisites

Before you begin, make sure you have the following installed on your system:

- [Vagrant](https://www.vagrantup.com/downloads)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Terraform](https://www.terraform.io/downloads)
- [Docker](https://docs.docker.com/get-docker/)

## Step 1: Clone the Repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/amar-rakhpasre/your-repo-name.git
cd your-repo-name
```

## Step 2: Initialize Vagrant VM

Use Vagrant to initialize and start a Virtual Machine:

```bash
vagrant up
vagrant ssh
```

## Step 3: Install Docker

Once inside the VM, install Docker if it is not already installed:

```bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo usermod -aG docker $USER
newgrp docker
```

## Step 4: Install Terraform

If Terraform is not installed, follow these steps:

```bash
sudo apt-get update && sudo apt-get install -y wget unzip
wget https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_amd64.zip
unzip terraform_1.9.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version
```

Ensure that Terraform is correctly installed by running:

```bash
terraform --version
```

## Step 5: Terraform Configuration

Create a `main.tf` file with the following content:

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.26.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx-tf"

  ports {
    internal = 80
    external = 8000
  }
}
```

## Step 6: Initialize Terraform

Run the following command to initialize Terraform:

```bash
terraform init
```

## Step 7: Apply Terraform Configuration

Deploy the infrastructure using Terraform:

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

## Step 8: Verify Deployment

After the deployment is complete, verify that the Nginx container is running:

```bash
docker ps
```

You should see an output similar to this:

```bash
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
ba4dd40ca144   nginx:latest   "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   0.0.0.0:8000->80/tcp   nginx-tf
```

## Step 9: Access Nginx on Host Machine

Now, you can access the Nginx web server on your host machine using the following URL:

```text
http://localhost:8000
```

You should see the default Nginx welcome page.

## Troubleshooting

- **Permission Denied**: If you encounter a "permission denied" error when running Docker commands, ensure that your user is added to the Docker group and re-login or use `newgrp docker`.

- **Port Forwarding Issues**: Ensure that the port `8000` on your VM is properly forwarded to the host machine.

## Conclusion

Congratulations! You've successfully deployed an Nginx web server using Docker and Terraform. This setup demonstrates the power of Infrastructure as Code (IaC) and containerization in modern DevOps practices.

---

Feel free to modify this guide as per your project requirements!

```

Make sure to replace `"your-repo-name"` with the actual name of your GitHub repository. This `.md` file can be included in your repository as `README.md` for clear instructions.
