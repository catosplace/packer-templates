# Catosplace Packer Templates
This repository contains [Packer](https://www.packer.io/) templates to build Ubuntu base images. Both server and desktop and a Catosplace Engineering base image based on the desktop variant.

These images will form the basis of Catosplace's new developer onboarding practice. They will use [Vagrant](https://www.vagrantup.com/) provisioning and [Dojo](https://github.com/kudulab/dojo) Docker-based development environments to reduce onboarding cycle time.

The Packer configurations provisions default tooling that Catosplace contributors regularly use into the Catosplace Engineering image.

## Current Source Templates
The currently provided source templates are:

* VirtualBox Ubuntu Server 20.04.2 AMD64
* VirtualBox Ubuntu Desktop 20.04.2 AMD64
* VirtualBox Catosplace Engineering

## Useful Information
Packer templates enable multiple OS, multiple virtualization technologies and output formats. The Catosplace Packer templates currently only support the Ubuntu OS, VirtualBox virtualization and Vagrant outputs.

### Ubuntu Versions
Current versions of Ubuntu provided are:

* 20.04.2

### VirtualBox
Currently, the Packer templates only build [VirtualBox](https://www.virtualbox.org/) images.

### Vagrant Boxes
The packer configuration uses the [Vagrant post-processor](https://www.packer.io/docs/post-processors/vagrant) to build a [Vagrant](https://www.vagrantup.com/) box derived from the Catosplace Engineering image.

### Catosplace Engineering Tooling
The currently installed tools are:

* [aws-vault](https://github.com/99designs/aws-vault)

## Requirements
The Packer templates require you to have the following tools available:

* [Packer](https://www.packer.io/)
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* [pre-commit](https://pre-commit.com/)

## Usage
The `packer` cli enables you to build the Packer template images and Vagrant box. 

### Building the Boxes
You can build all images at once, or each is individually using the `packer` cli.

You can build all of the images using the following command:
```
packer build.
```

You can build a single image using the `-only` cli parameter, passing an expression that identifies the box you wish to create based on the name. The command that follows would only build the server variant, as it only matches the server variant build name.
```
packer build \
  -only *server-amd64 .
```

### Pre-Commit Hooks
This repository leverages the [pre-commit](https://pre-commit.com/) project to configure Git pre-commit hooks. Currently, we run the `packer fmt` and `packer validate` commands at this time. You can run these checks before committing using the `pre-commit --run all-files` command.
