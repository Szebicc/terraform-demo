variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "tag_name" {
  type = string
}

variable "project_name" {
  description = "this will be used as a tag for resources"
  type = string
}
