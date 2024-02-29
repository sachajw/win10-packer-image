variable "name" {
type    = string
  default = "ubuntu2304"
}
variable "cpus" {
type    = string
  default = "2"
}
variable "memory" {
type    = string
  default = "2048"
}
variable "disk_size" {
type    = string
  default = "81920"
}
variable "iso_urls" {
type    = list(string)
  default = ["iso/ubuntu-23.04-live-server-amd64.iso", "https://releases.ubuntu.com/23.04/ubuntu-23.04-live-server-amd64.iso"]
}
variable "iso_checksum" {
type    = string
  default = "c7cda48494a6d7d9665964388a3fc9c824b3bef0c9ea3818a1be982bc80d346b"
}