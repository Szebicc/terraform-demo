variable "region" {
  default = "eu-west-2"
  type = string
  description = "Region for the aws resources"
}

variable "profile" {
  default = "default"
  type = string
  description = "profile for the region"
}

variable "project_name" {
  description = "this will be used as a tag for resources"
  type = string
}
