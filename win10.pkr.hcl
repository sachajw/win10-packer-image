packer {
  required_plugins {
    vagrant = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vagrant"
    }
    virtualbox = {
      version = "~> 1.0.5"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

source "virtualbox-iso" "win10" {
  boot_command = ["a<wait>a<wait>a"]
  boot_wait    = "-1s"
  cd_files = ["./answer_files/Autounattend.xml",
    "./script/fixnetwork.ps1",
    "./script/disable-screensaver.ps1",
    "./script/disable-winrm.ps1",
    "./script/enable-winrm.ps1",
    "./script/microsoft-updates.ps1",
    "./script/win-updates.ps1"
  ]
  communicator         = "winrm"
  cpus                 = 2
  memory               = 4096
  disk_size            = 262144
  hard_drive_interface = "sata"
  firmware             = "efi"
  guest_additions_mode = "disable"
  guest_os_type        = "Windows10_64"
  headless             = false
  iso_url              = "image/win10.iso"
  iso_checksum         = "af8d0e9efd3ef482d0ab365766e191e420777b2b"
  output_directory     = "win11"
  shutdown_command     = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  vm_name              = "win11"
  winrm_password       = "vagrant"
  winrm_timeout        = "6h"
  winrm_username       = "vagrant"
}

build {
  #sources = ["source.virtualbox-iso.win11"],["source.virtualbox-iso.win11arm"]
  #sources = ["source.virtualbox-iso.win11arm"]
  sources = ["source.virtualbox-iso.win10"]

  post-processor "vagrant" {
    keep_input_artifact  = false
    output               = "output_directory/win10_{{ .Provider}}.box"
    vagrantfile_template = "vagrantfile-win10.template"
  }
}
