/*
  The modules for the multiple-regions definition
  Copy the module and change the name, you can add the region as the module
*/

# WebServer Setup per Region
module "us-west-1" {
  source = "./shared"
  region = "us-west-1"
}

module "ca-central-1" {
  source = "./shared"
  region = "ca-central-1"
}