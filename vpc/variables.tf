variable "region_name" {
  type = string
}
variable "availability_zone_1a" {
  description = "Availability Zone for public subnet 1a"
  type        = string
}

variable "availability_zone_1b" {
  description = "Availability Zone for public subnet 1a"
  type        = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "internet_ip_cidr" {
  type = string
}
variable "public_web_subnet_1a_cidr" {
  description = "CIDR block for public subnet in AZ 1a"
  type        = string
}

variable "public_web_subnet_1b_cidr" {
  description = "CIDR block for public subnet in AZ 1a"
  type        = string
}

variable "private_app_subnet_1a_cidr" {
  description = "CIDR block for public subnet in AZ 1a"
  type        = string

}

variable "private_app_subnet_1b_cidr" {
  description = "CIDR block for public subnet in AZ 1a"
  type        = string

}

variable "private_db_subnet_1a_cidr" {
  description = "CIDR block for public subnet in AZ 1a"
  type        = string

}

variable "private_db_subnet_1b_cidr" {
  description = "CIDR block for public subnet in AZ 1a"
  type        = string

}

variable "public_web_subnet_1a_name" {
  description = "Name tag for public subnet 1a"
  type        = string

}

variable "public_web_subnet_1b_name" {
  description = "Name tag for public subnet 1a"
  type        = string

}

variable "private_app_subnet_1a_name" {
  description = "Name tag for public subnet 1a"
  type        = string

}

variable "private_app_subnet_1b_name" {
  description = "Name tag for public subnet 1a"
  type        = string

}

variable "private_db_subnet_1a_name" {
  description = "Name tag for public subnet 1a"
  type        = string

}

variable "private_db_subnet_1b_name" {
  description = "Name tag for public subnet 1a"
  type        = string

}

variable "public_route_name" {
  type = string

}

variable "private_route_name" {
  type = string

}

variable "igw_name" {
  type = string

}

variable "ngw_name" {
  type = string

}

variable "eip_name" {
  type = string

}
