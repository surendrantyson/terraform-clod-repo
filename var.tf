# Input Variables
variable "aws_regions_variable" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "ap-south-1"
}

variable "ec2_ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0376ec8eacdf70aae" # Amazon2 Linux AMI ID
}

variable "ec2_instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 1
}

# Assign When Prompted using CLI
variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type = list(string)
  #             0            1           2
  default = ["t2.micro", "t2.medium", "t2.large"]
  #default = "t2.micro"
}

variable "db_username" {
  description = "AWS RDS Database Administrator Username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "AWS RDS Database Administrator Password"
  type        = string
  sensitive   = true
}