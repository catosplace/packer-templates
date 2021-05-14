variable "boot_wait" {
  type        = string
  description = "The time to wait after booting the initial virtual machine before typing the boot command. The value of this should be a duration. Packer defaults this to 10s"
  default     = "5s"
}

variable "cpus" {
  type        = number
  description = "The number of cpus to use for building the VM. Packer defaults is 1"
  default     = 2
}

variable "disk_size" {
  type        = number
  description = "The size, in megabytes of the hard disk to create for the VM. Packer defaults this to 40000 (about 40GB)"
  default     = 40000
}

variable "hard_drive_interface" {
  type        = string
  description = "The type of controller that the primary hard drvie is attached to, Packer default is ide."
  default     = "sata"
}

variable "headless" {
  type        = bool
  description = "Packer defaults to building VirtualBox virtual machines by launching a GUI that shows the console of the machine bing built. When this is set to true, the machine will start without a console"
  default     = false
}

variable "iso_checksum" {
  type        = string
  description = "The checksum for the ISO file or virtual hard drive."
  default     = "d1f2bf834bbe9bb43faf16f9be992a6f3935e65be0edece1dee2aa6eb1767423"
}

variable "iso_filename" {
  type        = string
  description = "The file name of the guest operating system ISO image installation media"
  default     = "ubuntu-20.04.2-live-server-amd64.iso"
}

variable "iso_filepath" {
  type        = string
  description = "The file path within this repository to your local ISO image installation media"
  default     = "./ISOs"
}

variable "iso_mirror" {
  type        = string
  description = "The file mirror to use for the ISO image installation media"
  default     = "https://mirror.fsmg.org.nz/ubuntu-releases/focal"
}

variable "iso_url" {
  type        = string
  description = "A URL to the ISO containing the installation image or virtual hard drive (VHD or VHDX) file to clone"
  default     = "iso/ubuntu-20.04.1-live-server-amd64.iso"
}

variable "memory" {
  type        = number
  description = "The amount of memory to use for building the VM in megabytes. Packer default is 512 megabytes"
  default     = 4096
}

variable "ssh_username" {
  type        = string
  description = "The username to connect to SSH with. Required if using SSH"
  default     = "packer"
}

variable "ssh_password" {
  type        = string
  description = "A plaintext password to use to authenticate with SSH"
  default     = "packer"
}

variable "ssh_timeout" {
  type        = string
  description = "The time to wait for SSH to become avaialble. Packer uses this to determine when the machine has booted so this is usually quite long."
  default     = "45m"
}

variable "vbox_memory" {
  type        = number
  description = "The amount of memory to provide the VirtualBox VM in megabytes. Defaults to 2056"
  default     = 2056
}

variable "vbox_cpu" {
  type        = number
  description = "The number of cpus to use in the VirtualBox VM. Defaults to 2"
  default     = 2
}

variable "virtualbox_output_directory" {
  type        = string
  description = "The root file directory name for VirtualBox image creation"
  default     = "virtualbox-iso"
}