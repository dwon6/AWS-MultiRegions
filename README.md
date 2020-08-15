# MAP603 - AWS Multi-Region Deployment

This code can deploy web servers to multiple-regions by using modules.

![The Code Structure](https://github.com/dwon6/AWS-MultiRegions/blob/master/structure.JPG)

## How to use this code if you want to add the additional region.

* .region.tf:
The modules for the multiple-regions definition.

Copy the existing module and paste it, then modify the name to the new regional name.

* shared/variables.tf:
All variables for VPC and EC2.

Add the new AMI IDs in a new additional region, which are copied from the existing region, into the AMI variables. But, you have to add the new AMI with the regional name.

* $terraform init && terraform plan && terraform apply
