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
}