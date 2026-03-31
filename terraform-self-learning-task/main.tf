Task:

==>How to switch between different terraform versions instead of uninstall and install everytime
==>How to restrict terraform version into terraform configuration ( it should allow specific version only to run configurations)
==>Is there any other way to authenticate cloud env while integrating terraform (except keys process )
What is terragrunt how to configure to terraform what is the use case?

============================================================================================

✅ 1. Switch between Terraform versions (without reinstalling)

👉 Use tfenv (best and most common way)

🔹 Install (Mac)
brew install tfenv
🔹 Install versions
tfenv install 1.5.7
tfenv install 1.6.6
🔹 Switch version
tfenv use 1.5.7
🔹 Auto-switch per project

Create file:

echo "1.5.7" > .terraform-version

👉 Now when you enter that folder → Terraform auto switches 🔥

=========================================================================================

✅ 2. Restrict Terraform version in configuration

👉 Use this inside your Terraform code:

terraform {
  required_version = "~> 1.5.0"
}
🔍 What this means:
~> 1.5.0 → allows 1.5.x only
>= 1.5.0 → allows anything above
= 1.5.7 → exact version only

👉 If wrong version:

Error: Unsupported Terraform Core version

==============================================================================================

✅ 3. Authentication without keys (VERY IMPORTANT 🔐)

Yes — avoid hardcoded keys ❌
Use secure authentication methods 👇

🔹 AWS (Best Practice)

Use AWS IAM Role

Example:
provider "aws" {
  region = "us-east-1"
}

👉 Terraform automatically uses:

EC2 role
or SSO login
🔹 AWS SSO (for local machine)
aws configure sso
aws sso login
🔹 Azure

Use Azure Managed Identity

🔹 GCP

Use:

Service Account (with IAM binding)
Workload Identity (best)

👉 🔥 Golden Rule:

Never use access keys in code — always use roles/identity

✅ 4. What is Terragrunt + Use case

=====================================================================================================

👉 Terragrunt = Wrapper around Terraform

🔹 Problem without Terragrunt

You repeat same code everywhere:

backend config
provider config
variables

👉 messy 😵

🔹 What Terragrunt does
Reuse code
Manage multiple environments (dev/prod)
DRY principle (Don’t Repeat Yourself)
🔹 Example structure
live/
 ├── dev/
 │    └── ec2/terragrunt.hcl
 ├── prod/
 │    └── ec2/terragrunt.hcl
modules/
 └── ec2/
🔹 Sample terragrunt.hcl
terraform {
  source = "../../modules/ec2"
}

inputs = {
  instance_type = "t2.micro"
}
🔹 Key features
Remote state automation
Dependency handling
Environment separation
Less duplication
🔥 Real-world use case

👉 Company with:

Dev / QA / Prod environments
50+ services

Without Terragrunt → chaos
With Terragrunt → clean & reusable infra 🚀

🧠 Easy way to remember
Problem	Solution
Multiple Terraform versions	tfenv
Wrong version usage	required_version
Unsafe credentials	IAM Roles / SSO
Too much duplicate code	Terragrunt