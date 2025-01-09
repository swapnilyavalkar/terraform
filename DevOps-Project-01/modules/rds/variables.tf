variable "db_subnet_group_name" {
  description = "Name for the RDS subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
}

variable "primary_db_identifier" {
  description = "Identifier for the primary RDS instance"
  type        = string
}

variable "read_replica_identifier" {
  description = "Identifier for the read replica RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "Storage size for the RDS instance"
  type        = number
}

variable "storage_type" {
  description = "Storage type for the RDS instance"
  type        = string
}

variable "engine" {
  description = "Database engine for the RDS instance"
  type        = string
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
}

variable "instance_class" {
  description = "Instance class for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Security group IDs for RDS"
  type        = list(string)
}

variable "availability_zone" {
  description = "Availability zone for the primary RDS instance"
  type        = string
}

variable "read_replica_availability_zone" {
  description = "Availability zone for the read replica"
  type        = string
}

variable "publicly_accessible" {
  description = "Whether the read replica is publicly accessible"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
}
