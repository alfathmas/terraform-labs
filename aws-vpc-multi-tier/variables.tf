variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "tenancy" {
  type = string
  default = "default"
}

variable "true" {
  type = bool
  default = true
}

variable "false" {
  type = bool
  default = false
}

variable "public_subnets" {
  type = map
  default = {
    "public-subnet-1" = 1
    "public-subnet-2" = 2
  }
}

variable "private_subnets" {
  type = map
  default = {
    "private-subnet-1" = 1
    "private-subnet-2" = 2
  }
}

variable "cidr" {
  type = string
  default = "0.0.0.0/0"
}