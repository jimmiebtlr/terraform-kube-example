locals {
  cluster_name = "cluster"
  port         = "3000"
}

variable gcloud_project_id {}

provider "google" {
  project = "${var.gcloud_project_id}"
  zone    = "us-east1-c"
}

resource "google_container_cluster" "primary_cluster" {
  name = "${local.cluster_name}"

  node_pool {
    name               = "${local.cluster_name}"
    initial_node_count = 1
  }
}

resource "kubernetes_deployment" "example" {
  metadata {
    name      = "example"
  }

  spec {
    selector {
      app = "example"
    }

    template {
      metadata {
        labels {
          app = "example"
        }
      }

      spec {
        container {
          image                           = "hello-world"
          name                            = "example"

          env = [
            {
              name  = "PORT"
              value = "${local.port}"
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "example-service" {
  metadata {
    name = "example-service"
  }

  spec {
    selector {
      app = "example"
    }

    port {
      port        = 80
      target_port = "${local.port}"
    }
  }
}
