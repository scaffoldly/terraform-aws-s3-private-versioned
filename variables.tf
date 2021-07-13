variable "name" {}

variable "read_only_principals" {
  default = []
}

variable "read_write_principals" {
  default = []
}

variable "write_only_principals" {
  default = []
}

variable "write_only_services" {
  default = []
}

variable "root_principal" {
  default = "root"
}

variable "allowed_origins" {
  default = ["*"]
}

variable "notification_prefixes" {
  default = []
}
