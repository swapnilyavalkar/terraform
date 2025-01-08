variable "vpc_name" {
  type    = string
}

variable "vpc_cidr" {
  type    = string
}

variable "internet_ip_cidr" {
  type    = string
  
}

variable "public_route_name" {
  type    = string
  
}

variable "private_route_name" {
  type    = string
  
}

variable "igw_name" {
  type    = string
  
}

variable "ngw_name" {
  type    = string
  
}

variable "eip_name" {
  type    = string
  
}

variable "subnets" {
  description = "Map of subnets with their CIDR blocks, availability zones, and tags"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    public            = bool
    name              = string
  }))
}