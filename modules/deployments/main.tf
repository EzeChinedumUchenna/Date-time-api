# Define a Kubernetes namespace
resource "kubernetes_namespace" "api_namespace" {
  metadata {
    name = var.namespace
  }
}

# Define a Kubernetes ConfigMap for NGINX configuration
resource "kubernetes_config_map" "nginx_config" {
  metadata {
    name      = "nginx-config"
    namespace = kubernetes_namespace.api_namespace.metadata[0].name
  }

  data = {
    "default.conf" = <<-EOT
      server {
        listen 80;
        server_name localhost;

        location / {
          root   /usr/share/nginx/html;
          index  index.html index.htm;
        }
      }
    EOT
  }
}

# Define a Kubernetes Deployment
resource "kubernetes_deployment" "api_deployment" {
  metadata {
    name      = var.deployment_name
    namespace = kubernetes_namespace.api_namespace.metadata[0].name
    labels = {
      app = "my-api"
      //environment = var.environment  # Adding an environment label for better management
    }
  }

  spec {
    replicas = var.replicas  # Consider adding Horizontal Pod Autoscaler (HPA) for dynamic scaling

    selector {
      match_labels = {
        app = "my-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-api"
        }
      }

      spec {
        #security_context {
        #  run_as_user  = 1000  # Run as non-root user for better security
        #  run_as_group = 3000
        #  fs_group     = 2000
        #}

        container {
          image = var.image
          name  = "api-container"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          /***liveness_probe {  # Ensuring the container is running properly
            http_get {
              path = "/healthz"
              port = 80
            }
            initial_delay_seconds = 10
            period_seconds        = 10
          }

          readiness_probe {  # Ensuring the container is ready to accept traffic
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 10
            period_seconds        = 5
          }***/

          /**# Mount the ConfigMap for NGINX configuration
          volume_mount {
            name       = "nginx-config-volume"
            mount_path = "/etc/nginx/conf.d"
            sub_path   = "default.conf"
          }**/
        }

        /**# Define the volumes section
        volume {
          name = "nginx-config-volume"
          config_map {
            name = kubernetes_config_map.nginx_config.metadata[0].name
          }
        }***/

        /*** env_from {
          config_map_ref {
            name = var.config_map_name  # Assuming a ConfigMap is defined for environment variables
          }
        }

        env_from {
          secret_ref {
            name = var.secret_name  # Assuming a Secret is defined for sensitive data
          }
        }

        volume_mounts {
          name       = "config-volume"
          mount_path = "/etc/config"
        }

        volume_mounts {
          name       = "secret-volume"
          mount_path = "/etc/secrets"
        }
      }

      volume {
        name = "config-volume"
        config_map {
          name = var.config_map_name
        }
      }

      volume {
        name = "secret-volume"
        secret {
          secret_name = var.secret_name
        }
      }***/
      }
    }
  }
}

# Define a Kubernetes Service
resource "kubernetes_service" "api_service" {
  metadata {
    name      = var.service_name
    namespace = kubernetes_namespace.api_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "my-api"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"  # Consider external vs internal based on your use case
  }
}

# Define a Kubernetes Ingress
/**resource "kubernetes_ingress" "api_ingress" {
  metadata {
    name      = "api-ingress"
    namespace = kubernetes_namespace.api_namespace.metadata[0].name
    annotations = {  # Adding annotations for better control
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }

  spec {
    rule {
      http {
        path {
          path    = "/"
          backend {
            service_name = kubernetes_service.api_service.metadata[0].name
            service_port = 80
          }
        }
      }
    }
  }


# Horizontal Pod Autoscaler (HPA)
resource "kubernetes_horizontal_pod_autoscaler_v2" "api_hpa" {
  metadata {
    name      = "api-hpa"
    namespace = kubernetes_namespace.api_namespace.metadata[0].name
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.api_deployment.metadata[0].name
    }

    min_replicas = 2
    max_replicas = 10

    metric {
      type = "Resource"

      resource {
        name = "cpu"

        target {
          type               = "Utilization"
          average_utilization = 70  # Target CPU utilization percentage
        }
      }
    }
  }
}**/
