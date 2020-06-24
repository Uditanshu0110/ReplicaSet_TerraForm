provider "kubernetes" {
  config_context_cluster   = "minikube"
}
resource "kubernetes_deployment" "myrs" {
  metadata {
    name = "myreplicaset"
  }
spec {
    replicas = 3
    selector {
      match_labels = {
        env = "dev"
	      dc = "IN"
	      app = "webserver"
      }
	    match_expressions{
		        key = "dc"
            operator = "In"
            values = [ "IN" , "UK" ]
    }
	    match_expressions{
		        key = "env"
            operator = "In"
            values = [ "dev" , "manage" ]
    }
	    match_expressions{
		        key = "app"
            operator = "In"
            values = [ "webserver" , "appserver" ]
    }
}
template {
      metadata {
        name = "mypod1"
        labels = {
          env = "dev"
	        dc = "IN"
	        clapp = "webserver"
        }
      }
      spec {
        container {
          image = "vimal13/apache-webserver-php"
          name  = "uditrs"
}
}
}
}
}