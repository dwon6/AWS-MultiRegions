#This terraform can deploy web servers to multiple-regions by using modules.
# The Code Structure:
|-- region.tf
|--  shared/
    |-- ec2.tf
    |-- outputs.tf
    |-- provider.tf
    |-- variables.tf
    |-- variables.tfvars
    |--  vpc.tf

How to use this code if you want to add the additional region.
1. .region.tf:  The modules for the multiple-regions definition
Copy the existing module and paste it, then modify it as the additional new region name so that you can add the region as the module.
2. shared/variables.tf: All variables for VPC and EC2
Add the new AMI IDs in a new additional region, which are copied from the existing region, into the AMI variables. But, you have to add the new AMI with the region name.
3. $terraform init && terraform plan && terraform apply
