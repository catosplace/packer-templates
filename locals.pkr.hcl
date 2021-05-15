locals {
  boot_command = [<<-EOF
    <enter><enter><f6><esc><wait>
     autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/
    <enter>
  EOF
  ]

  local_iso_path  = "${var.iso_filepath}/${var.iso_filename}"
  mirror_iso_path = "${var.iso_mirror}/${var.iso_filename}"

  // fileset lists all files in the http directory as a set, we convert that
  // set to a list of strings and we then take the directory of the first
  // value. This validates that the http directory exists even before starting
  // any builder/provisioner.
  http_directory = dirname(convert(fileset(".", "./http/*"), list(string))[0])

  vboxmanage_configurations = {
    "vram"               = "${var.vbox_vram}"
    "graphicscontroller" = "${var.vbox_graphicscontroller}"
    "nic"                = "${var.vbox_nic}"
    "memory"             = "${var.vbox_memory}"
    "cpus"               = "${var.vbox_cpus}"
  }

  vboxmanage_server_configuration = [
    ["modifyvm", "{{ .Name }}", "--vram", "8"],
    ["modifyvm", "{{ .Name }}", "--graphicscontroller", "${lookup(local.vboxmanage_configurations, "graphicscontroller", "vmsvga")}"],
    ["modifyvm", "{{ .Name }}", "--nic1", "${lookup(local.vboxmanage_configurations, "nic", "nat")}"],
    ["modifyvm", "{{ .Name }}", "--memory", "${lookup(local.vboxmanage_configurations, "memory", "4096")}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${lookup(local.vboxmanage_configurations, "cpus", "2")}"]
  ]

  vboxmanage_desktop_configuration = [
    ["modifyvm", "{{ .Name }}", "--vram", "${lookup(local.vboxmanage_configurations, "vram", "8")}"],
    ["modifyvm", "{{ .Name }}", "--graphicscontroller", "${lookup(local.vboxmanage_configurations, "graphicscontroller", "vmsvga")}"],
    ["modifyvm", "{{ .Name }}", "--nic1", "${lookup(local.vboxmanage_configurations, "nic", "nat")}"],
    ["modifyvm", "{{ .Name }}", "--memory", "${lookup(local.vboxmanage_configurations, "memory", "4096")}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${lookup(local.vboxmanage_configurations, "cpus", "2")}"]
  ]

  vboxmanage_engineering_configuration = [
    ["modifyvm", "{{ .Name }}", "--vram", "${lookup(local.vboxmanage_configurations, "vram", "8")}"],
    ["modifyvm", "{{ .Name }}", "--graphicscontroller", "${lookup(local.vboxmanage_configurations, "graphicscontroller", "vmsvga")}"],
    ["modifyvm", "{{ .Name }}", "--nic1", "${lookup(local.vboxmanage_configurations, "nic", "nat")}"],
    ["modifyvm", "{{ .Name }}", "--audio", "dsound"],
    ["modifyvm", "{{ .Name }}", "--audiocontroller", "ac97"],
    ["modifyvm", "{{ .Name }}", "--audiocodec", "ad1980"],
    ["modifyvm", "{{ .Name }}", "--audioout", "on"],
    ["modifyvm", "{{ .Name }}", "--usbcardreader", "on"],
    ["modifyvm", "{{ .Name }}", "--usbohci", "on"],
    ["modifyvm", "{{ .Name }}", "--usbehci", "on"],
    ["modifyvm", "{{ .Name }}", "--memory", "${lookup(local.vboxmanage_configurations, "memory", "4096")}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${lookup(local.vboxmanage_configurations, "cpus", "2")}"]
  ]
}