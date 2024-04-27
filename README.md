# TerraKubeSphere I: Exploring the Azure Cloud with Terraform, Docker and Kubernetes.

_At the end of this README, you can find the VideoTutorial._

## Introduction: Design. 

 <div align="justify"> 
In this Post, we are going to deploy our application as explained in this design using tools such as Docker, Kubernetes or Terraform.
The first thing we will do is to create a Docker image of our application and upload it to our Docker Hub repository. Subsequently, we will use Terraform to deploy several resources in our Azure account. Among them, we will deploy an ACR along with the Docker image we created earlier to store it there and have it ready to deploy to our AKS. In addition, we will also deploy monitoring resources to later associate them to the resources we deploy, such as Grafana and Prometheus. Finally, once everything is deployed, we will use Kubernetes to deploy the image of our app in the AKS from our ACR. Accessing it through a browser. </div> <br>

<p align="center">
  <img src="https://github.com/JavierRamirezMoral/TerraKubeSphere-Azure/blob/main/Images/portada.jpg"/>
</p>
<br> 

## Part 1: Build a Docker Image and Upload it to Docker Hub. 

In this first part, we will see how to create our image and put it inside a Docker container and how to upload it to our Docker Hub repository. 

### What is Docker? 
 <div align="justify"> Docker is a versatile platform designed to streamline the development, deployment, and operation of applications. It empowers users to decouple their applications from the underlying infrastructure, facilitating swift software delivery. With Docker, managing infrastructure becomes as seamless as managing applications. Leveraging Docker's efficient techniques for packaging, testing, and deploying code, you can notably minimize the time lag between coding and production deployment. </div>

### Why Do we need Docker? 

We need Docker for several reasons, but let's illustrate it with an example: <br>

<div align="justify">  Imagine you're a DevOps engineer responsible for deploying and managing a web application that consists of multiple microservices. Each microservice is developed by a different team using various programming languages and frameworks. Traditionally, deploying and managing these microservices across different environments would be complex and time-consuming due to the diverse dependencies and configurations. 

Here's how Docker can address these challenges: 

Using Docker, you can containerize each microservice along with its dependencies and configurations. This means you can create a Docker container for each microservice, ensuring that it runs consistently across development, testing, and production environments. 

Now, let's say one of the microservices requires a specific version of a database, another needs a particular version of a programming language, and yet another relies on a specific library. Instead of installing and managing these dependencies manually on each server, you can encapsulate everything within Docker containers. 

So, regardless of the underlying infrastructure or environment, you can simply deploy these Docker containers containing your microservices. Docker's lightweight nature ensures that these containers can be spun up quickly and scaled horizontally to handle varying levels of traffic. 

Furthermore, Docker's orchestration tools like Kubernetes or Docker Swarm allow you to automate deployment, scaling, and management of these containers, providing resilience and high availability to your application. 

In summary, Docker simplifies the deployment and management of complex applications with multiple microservices by encapsulating them into portable, self-contained containers. This approach enhances consistency, scalability, and efficiency, making it easier for DevOps teams to maintain and scale applications in modern, dynamic environments. </div>
 
### Advantages of Docker: 

* Docker is lightweight as it dynamically acquires resources from the host OS when needed, reducing upfront resource allocation costs. 

* Enhances continuous integration efficiency by allowing the use of the same container image throughout the deployment process. 

* Offers versatility by being compatible with physical hardware, virtual hardware, and cloud environments. 

* Facilitates image reuse, enabling developers to efficiently utilize previously created containers. 

* Accelerates the creation process due to its quick setup time. 

### Disadvantages of Docker: 

* Unsuitable for applications requiring rich graphical user interfaces (GUIs). 

* Challenges arise in managing a large number of containers efficiently. 

* Lack of cross-platform compatibility may restrict application deployment between different operating systems. 

* Ideally suited when both development and testing environments share the same operating system. 

* Lacks built-in solutions for data backup and recovery, necessitating additional tools or processes. 

![Alt text](https://github.com/JavierRamirezMoral/TerraKubeSphere-Azure/blob/main/Images/docker1.png)
  
## Part 2: Implementation of resources and push image with Terraform in Azure.  

<div align="justify">  In this second part, we will examine the various Terraform files required to deploy all the resources needed for this scenario. The primary components include an Azure Container Registry (ACR), where our Docker image will be stored. We'll deploy both the ACR and AKS (Azure Kubernetes Service) in the same Terraform file. Later, we'll deploy our image from the ACR onto the AKS using Kubernetes. Additionally, we'll set up monitoring resources such as Prometheus and Grafana. </div>

 

### What is Terraform? 

<div align="justify">  HashiCorp Terraform is a tool for infrastructure management through code. It allows you to describe your cloud and on-premises resources using simple, readable configuration files. These files can be versioned, reused, and shared across your team. With Terraform, you can maintain a unified workflow to create and oversee your entire infrastructure from start to finish. It's capable of handling both fundamental components such as computing power, storage, and networking, as well as more advanced elements like DNS configurations and features from Software as a Service (SaaS) providers. </div>

### Why Do we need Terraform? 

We need Terraform for various reasons, but let's delve into an example to illustrate its importance: <br>

<div align="justify"> Imagine you're part of a team tasked with deploying a web application to the cloud. Your application relies on multiple cloud services such as virtual machines, databases, load balancers, and networking configurations. Traditionally, setting up and managing these resources manually through the cloud provider's console or command-line interface would be cumbersome and error-prone, especially as your infrastructure grows in complexity. 

Here's how Terraform can help: 

With Terraform, you can define your entire infrastructure as code using simple, human-readable configuration files. These files describe the desired state of your infrastructure, specifying the cloud resources, their configurations, dependencies, and relationships. For instance, you can define the number of virtual machines, their sizes, networking configurations, and any associated storage or databases—all within a Terraform configuration file. 

Now, let's say you need to deploy your application to a staging environment for testing. Instead of manually provisioning each resource, you can use Terraform to automate the entire process. By running a single command, Terraform will analyze the current state of your infrastructure, determine the necessary changes to achieve the desired state defined in your configuration files, and provision or update the resources accordingly. 

Furthermore, Terraform's ability to create "infrastructure as code" allows you to version-control your configurations using tools like Git. This means you can track changes, collaborate with team members, and roll back to previous configurations if needed, providing greater consistency and reliability across your infrastructure. 

Now, let's fast forward to when you're ready to deploy your application to production. With Terraform, you can reuse the same configuration files used in the staging environment, ensuring consistency and minimizing the risk of errors between environments. Additionally, Terraform's modular design enables you to abstract common configurations into reusable modules, promoting code reuse and maintainability across projects. 

In summary, Terraform streamlines the process of provisioning, managing, and scaling infrastructure by treating it as code. It improves efficiency, reduces manual errors, promotes collaboration, and provides a consistent and reliable approach to managing infrastructure across different environments and stages of the application lifecycle. </div>

### Advantages of Terraform: 

* Infrastructure as Code (IaC): Terraform allows infrastructure to be defined as code, providing version control, collaboration, and automation benefits. 

* Multi-Cloud Provisioning: It supports provisioning across multiple cloud providers, enabling organizations to avoid vendor lock-in and utilize best-of-breed services. 

* Resource Graph: Terraform builds a dependency graph of resources, enabling it to determine the order of resource creation or destruction, ensuring smooth deployments. 

* Modularity and Reusability: Terraform's modular design facilitates code reuse through modules, reducing duplication of code and simplifying management. 

* Immutable Infrastructure: With Terraform, infrastructure is treated as immutable, promoting consistency, predictability, and easier rollback in case of issues. 

### Disadvantages of Terraform: 

* Learning Curve: Terraform has a steep learning curve, especially for those new to infrastructure as code and its associated concepts. 

* State Management Complexity: Managing Terraform's state file can become complex, especially in team environments or when dealing with multiple configurations. 

* Limited Abstraction: Terraform's abstraction layers may be limited, leading to verbosity and boilerplate code in certain scenarios. 

* Continuous Integration Challenges: Integrating Terraform into continuous integration (CI) pipelines can be challenging due to its state management and dependency resolution. 

* Lack of Built-in Testing: Terraform lacks comprehensive built-in testing capabilities, requiring additional tools and practices to ensure infrastructure reliability and resilience. 

<div>
  <img  align=center src="https://github.com/JavierRamirezMoral/TerraKubeSphere-Azure/blob/main/Images/terraform.png">
</div>

## Part 3: Deploy Image with Kubernetes in AKS. 

<div align="justify"> In this third and final part, we will define a YAML file containing a deployment that specifies the image of our application and the Azure Container Registry (ACR) where it's stored. Additionally, we'll include a service to expose the application. </div>

### What is Kubernetes? 

<div align="justify">  Kubernetes, often abbreviated as “K8s”, orchestrates containerized applications to run on a cluster of hosts. The K8s system automates the deployment and management of cloud native applications using on-premises infrastructure or public cloud platforms. It distributes application workloads across a Kubernetes cluster and automates dynamic container networking needs. Kubernetes also allocates storage and persistent volumes to running containers, provides automatic scaling, and works continuously to maintain the desired state of applications, providing resiliency. </div>

### Why Do we need Kubernetes? 

We need Kubernetes for a variety of reasons, but let's delve into an example to illustrate its significance: <br>

<div align="justify"> Imagine you're running a large-scale online shopping platform that experiences fluctuating traffic throughout the day. During peak hours, your website receives a surge in visitors, requiring additional server resources to handle the increased load. Traditionally, managing this dynamic workload manually would be challenging and inefficient, as it would involve provisioning, deploying, and scaling servers manually, often leading to downtime or performance issues. 

Here's how Kubernetes can address these challenges: 

With Kubernetes, you can orchestrate the deployment and scaling of containerized applications across a cluster of servers, known as nodes. Each application component is encapsulated within a container, which ensures consistency and portability across different environments. 

Now, let's consider your online shopping platform. You can containerize various components of your application, such as the frontend, backend services, databases, and caching layers. Kubernetes allows you to define the desired state of your application using declarative configuration files, specifying parameters like the number of replicas, resource requirements, and networking configurations. 

During peak hours, when the demand for your platform increases, Kubernetes automatically scales up the number of container replicas to handle the additional load. It intelligently distributes these replicas across available nodes in the cluster, ensuring optimal resource utilization and fault tolerance. Conversely, during periods of low traffic, Kubernetes scales down the number of replicas to conserve resources and minimize costs. 

Furthermore, Kubernetes provides built-in features for service discovery, load balancing, and automated health checks, ensuring that traffic is routed efficiently to healthy instances of your application. It also supports rolling updates and canary deployments, allowing you to update your application seamlessly without downtime or disruptions. 

In summary, Kubernetes simplifies the management of containerized applications by automating deployment, scaling, and maintenance tasks. It improves resource utilization, enhances application reliability, and enables rapid innovation, making it an essential tool for modern, cloud-native architectures like microservices and distributed systems. </div>


### Advantages of Kubernetes: 

* Scalability: Kubernetes enables automatic scaling of applications based on demand, ensuring optimal resource utilization and performance. 

* High Availability: It provides built-in mechanisms for load balancing, self-healing, and rolling updates, ensuring high availability and reliability of applications. 

* Portability: Kubernetes abstracts away the underlying infrastructure, allowing applications to run consistently across various environments, whether on-premises or in the cloud. 

* Orchestration: Kubernetes automates the deployment, scaling, and management of containerized applications, simplifying complex tasks and reducing operational overhead. 

* Ecosystem: Kubernetes has a vast ecosystem of tools, plugins, and community support, providing solutions for monitoring, logging, security, and other operational needs. 

 

### Disadvantages of Kubernetes: 

* Complexity: Kubernetes has a steep learning curve and can be complex to set up and manage, especially for teams without prior experience with container orchestration platforms. 

* Resource Intensive: Running Kubernetes clusters can be resource-intensive, requiring significant compute, memory, and storage resources, which may lead to higher infrastructure costs. 

* Networking Complexity: Configuring networking in Kubernetes clusters, especially in multi-cloud or hybrid environments, can be challenging and may require additional networking expertise. 

* Operational Overhead: While Kubernetes automates many tasks, managing and maintaining Kubernetes clusters still requires ongoing operational effort, including monitoring, troubleshooting, and upgrading. 

* Compatibility Issues: Kubernetes ecosystem is rapidly evolving, which can lead to compatibility issues between different versions of Kubernetes, third-party tools, and applications, requiring careful planning and testing during upgrades and migrations. 

 

![Alt text](https://github.com/JavierRamirezMoral/TerraKubeSphere-Azure/blob/main/Images/kubernetes.jpg)


 # VideoTutorial in YT:

 [<img src="https://github.com/JavierRamirezMoral/TerraKubeSphere-Azure/blob/main/Images/PortadaVideo.png" width="100%">](https://youtu.be/h1270o-moR8?si=-KoWb_I6jKGYiCUu "Now in Android: 55")

Autor/a: Javier Ramírez Moral   

Curso: Administración de Sistemas MultiCloud con Azure, AWS y GCP.   

Centro: Tajamar   

Año académico: 2023-2024  

LinkedIn: https://www.linkedin.com/in/javier-ramirez-moral/ 
 
