terraform {
  backend "s3" {
    bucket = "feelinggoodmix"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    use_lockfile = true #dynamodb no longer required for state locking in s3 backed we can use lockfile.
    #terraform version should be 1.10 and above to use the lockfile for state locking in s3 backend.
  }
}
