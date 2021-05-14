build {
  name = "catosplace"

  # Build with `packer build .`
  # Or build individually with:
  #   `packer build --only=*server-amd64`
  #   `packer build --only=*desktop-amd64`
  sources = [
    "source.virtualbox-iso.ubuntu-20_04-server-amd64",
    "source.virtualbox-iso.ubuntu-20_04-desktop-amd64"
  ]

  provisioner "shell" {
    only = ["virtualbox-iso.ubuntu-20_04-desktop-amd64"]

    environment_vars = [
      "SSH_USERNAME=${var.ssh_username}"
    ]
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts = [
      "scripts/desktop.sh"
    ]
  }
}