variable "bucket_name_prefix" {
  type        = string
  description = "A prefix name for the bucket"
}

variable "read_only_principals" {
  default     = []
  description = "The ARNs of users/roles/etc that have read-only access to the bucket"
}

variable "read_write_principals" {
  default     = []
  description = "The ARNs of users/roles/etc that have read-write access to the bucket"
}

variable "write_only_principals" {
  default     = []
  description = "The ARNs of users/roles/etc that have write-only access to the bucket"
}

variable "write_only_services" {
  default     = []
  description = "The AWS services that have write-only access to the bucket (e.g. ses.amazonaws.com, lambda.amazonaws.com)"
}

variable "root_principal" {
  default     = "root"
  description = "The root prinicipal. In most cases leave this as 'root'"
}

variable "notification_prefixes" {
  default     = []
  description = "The object prefixes to create SNS notifications for (e.g. ['folder1/', 'folder2/'] or [''] for everything)"
}

variable "public_access" {
  default = false
}
