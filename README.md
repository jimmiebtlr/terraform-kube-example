This is an example of a basic terraform + kubernetes config.

This config will
- Create a cluster on google cloud (optional depending on your setup).
- Create a kubernetes deployment to manage your microservice.
- Create a service suitable for other microservices to use in api calls etc.
  - This is an abstraction to deal with providing a common interface when you have many service containers running.



# Use

## Terraform providers needed
This assumes you have golang installed and working on your machine, as well as
the google cloud tool installed and configured to provide default credentials.
```
# install terraform
curl -LO https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip && \
  unzip terraform_0.11.7_linux_amd64.zip && \
  cp terraform /usr/local/bin/terraform

# install specific providers
go get github.com/terraform-providers/terraform-provider-google
go get github.com/sl1pm4t/terraform-provider-kubernetes
```

To setup the terraform tool
```
terraform init --plugin-dir=$GOPATH/bin
```

To see the intended changes to your infrastrucutre
```
terraform plan -var="gcloud_project_id=$GCLOUD_PROJECT_ID"
```

To apply the changes (will prompt to make sure, and show changes from previous step)
```
terraform apply -var="gcloud_project_id=$GCLOUD_PROJECT_ID"
```



# About Terraform

Terraform provides a declarative syntax to describe your infrastructure.  It uses
this compared with your current infrastructure state to determine what changes to make.
A terraform provider (plugin) handles converting the syntax to some api calls (eg, gcloud).

Not everything can be changed about a specific resource, in these cases terraform
will delete and recreate the service.  Sometimes this is desired, others it can be
destructive.
