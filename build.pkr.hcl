build {
  name = "catosplace"

  # Build with `packer build .`
  # Or build individually with:
  #   `packer build -only=*server-amd64 .`
  #   `packer build -only=*desktop-amd64 .`
  #   `packer build -only=*catosplace-engineering .`
  sources = [
    "source.virtualbox-iso.ubuntu-20_04-server-amd64",
    "source.virtualbox-iso.ubuntu-20_04-desktop-amd64",
    "source.virtualbox-iso.catosplace-engineering"
  ]

  provisioner "shell" {
    except = ["virtualbox-iso.ubuntu-20_04-server-amd64"]

    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "SSH_USERNAME=${var.ssh_username}"
    ]
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts = [
      "scripts/desktop.sh"
    ]
    expect_disconnect = true
  }

  provisioner "shell" {
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "INSTALL_VAGRANT_KEY=${var.install_vagrant_key}",
      "SSH_USERNAME=${var.ssh_username}",
      "SSH_PASSWORD=${var.ssh_password}",
      "UPDATE=${var.update}",
      "VAGRANT_INSECURE_KEY=${var.vagrant_insecure_key}",
      "VAGRANT_SSH_USERNAME=${var.vagrant_ssh_username}",
      "VAGRANT_SSH_PASSWORD=${var.vagrant_ssh_password}"
    ]
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts = [
      "scripts/update.sh",
      "scripts/vagrant.sh",
      "scripts/sshd.sh",
      "scripts/virtualbox.sh",
      "scripts/motd.sh",
    ]
    expect_disconnect = true
  }

  provisioner "shell" {
    only = ["virtualbox-iso.ubuntu-20_04-server-amd64"]

    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive"
    ]
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts = [
      "scripts/minimize.sh"
    ]
    expect_disconnect = true
  }

  provisioner "shell" {
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "SSH_USERNAME=${var.ssh_username}"
    ]
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts = [
      "scripts/cleanup.sh"
    ]
    expect_disconnect = true
  }

  provisioner "shell" {
    only = ["virtualbox-iso.catosplace-engineering"]

    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "AWS_VAULT_VERSION=6.3.1"
    ]
    execute_command = "echo '${var.ssh_password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    scripts = [
      "scripts/catosplace/aws.sh"
    ]
    expect_disconnect = true
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    output              = "vagrant/{{ .Provider }}-catosplace-engineering.box"
  }

}