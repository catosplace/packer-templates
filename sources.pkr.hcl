source "virtualbox-iso" "ubuntu-20_04-server-amd64" {
  boot_command         = local.boot_command
  boot_wait            = var.boot_wait
  cpus                 = var.cpus
  disk_size            = var.disk_size
  guest_additions_mode = "disable"
  guest_os_type        = "Ubuntu_64"
  hard_drive_interface = var.hard_drive_interface
  headless             = var.headless
  http_directory       = local.http_directory
  iso_checksum         = var.iso_checksum
  iso_urls = [
    local.local_iso_path,
    local.mirror_iso_path,
    var.iso_url
  ]
  memory           = var.memory
  output_directory = "${var.virtualbox_output_directory}/ubuntu-20_04-server-amd64"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  ssh_username     = var.ssh_username
  ssh_password     = var.ssh_password
  ssh_timeout      = var.ssh_timeout
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--memory", "${var.vbox_memory}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.vbox_cpu}"],
  ]
}

source "virtualbox-iso" "ubuntu-20_04-desktop-amd64" {
  boot_command         = local.boot_command
  boot_wait            = var.boot_wait
  cpus                 = var.cpus
  disk_size            = var.disk_size
  guest_additions_mode = "disable"
  guest_os_type        = "Ubuntu_64"
  hard_drive_interface = var.hard_drive_interface
  headless             = var.headless
  http_directory       = local.http_directory
  iso_checksum         = var.iso_checksum
  iso_urls = [
    local.local_iso_path,
    local.mirror_iso_path,
    var.iso_url
  ]
  memory           = var.memory
  output_directory = "${var.virtualbox_output_directory}/ubuntu-20_04-desktop-amd64"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  ssh_username     = var.ssh_username
  ssh_password     = var.ssh_password
  ssh_timeout      = var.ssh_timeout
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--memory", "${var.vbox_memory}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.vbox_cpu}"],
  ]
}