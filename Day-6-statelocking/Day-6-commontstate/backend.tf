terraform {
  backend "s3" {
    bucket = "feelinggoodmix"
    key    = "terraform.tfstate" # if same path already used in different directory not a good parctice to use here.
    key   = "Day-6-statelocking/terraform.tfstate" # this is the best practice to use different path for different project in same bucket.
    region = "ap-south-1"
  }
}
# here we are using s3 as backend to store our state file. we can also use other backends like consul, vault, etc. but s3 is the most commonly used backend for terraform state file. we can also use local backend to store our state file in local machine but it is not recommended for production environment.
#if we use common s3 path for two different terraform projects then they will overwrite each other's state file and we will lose our state file. to avoid this we can use different key for each project in s3 bucket. for example, we can use "project1/terraform.tfstate" and "project2/terraform.tfstate" as key for two different projects. this way we can keep our state file safe and avoid overwriting. 
