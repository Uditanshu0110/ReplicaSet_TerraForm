# ReplicaSet_TerraForm

Container orchestration is all about managing the lifecycles of containers, especially in large, dynamic environments.

**What is Replica Set ?**

A ReplicaSet's purpose is to maintain a stable set of replica Pods running at any given time. As such, it is often used to guarantee the availability of a specified number of identical Pods.

**Prerequisite for this task -**

You should have MINIKUBE, KUBECTL and TERRAFORM installed in your system.
First Let's create replica set by writing YAML file then we can easily trace and create replica set using terraform.

**TERRAFORM CODE**

First we have to give the provider name in TerraForm code. In this case provider is Kubernetes.
```
provider "kubernetes" {
  config_context_cluster   = "minikube"
}
```
In terraform doc we have no resources like replica set or same thing as replica set but we have some options in the Kubernetes_Deployment resources.
```
resource "kubernetes_deployment" "myrs" {
  metadata {
    name = "myreplicaset" //NAME OF YOUR CHOICE
  }
  ```
Now we have to specify that how much replicas we desire. Spec defines the specification of the desired behavior of the deployment.
`spec {
    replicas = 3`
    
After giving our desire it's time to give some selectors. Selector is a label query over pods that should match the Replicas count. Match_Expressions is a list of node selector requirements by node's labels.
```
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
```
After match_expressions if there is already POD created then POD matches with this expression will get returns but if none of the POD matches with this expression replica set will create a new POD as per the given template.
```
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
```
Here, I have given the image and if none of the POD is there it will automatically pull image from the docker hub and create a POD.

**Commands used**

**terraform init - For downloading required PLUGINS.
terraform apply - This command will run our code.
kubectl get pods - This command will show all the PODS.
kubectl get rs - This command will show all the Replica Set that we have.
terraform destroy - This command will destroy all our created PODS and REPLICA SET.**
