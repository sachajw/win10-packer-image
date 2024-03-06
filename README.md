# Packer, Vagrant and VirtualBox Windows 10 Image Generation and Deployment

- Build 'virtualbox-iso.win10' finished after 1 hour 10 minutes.
```
Processor	12th Gen Intel(R) Core(TM) i5-12400F   2.50 GHz
Installed RAM	32,0 GB (31,9 GB usable)
System type	64-bit operating system, x64-based processor
```

## [Hashicorp Packer](https://developer.hashicorp.com/packer)
- Packer is a tool that lets you create identical machine images for multiple platforms from a single source template
- Packer can create golden images to use in image pipelines

#### HashiCorp Packer Benefits
- `Automation in Image Creation:` Packer automates the creation of machine images, allowing for the consistent setup of VMs, Docker containers, and other platforms without manual intervention. This reduces errors and inconsistencies that can occur when provisioning machines manually.
- `Multi-Provider Portability:` It supports multiple builders such as Amazon EC2, VMware, Docker, and more. This allows you to create identical machine images for different platforms from a single source configuration, simplifying multi-cloud and multi-platform deployments.
- `Immutable Infrastructure:` By using Packer to create machine images, you can adopt an immutable infrastructure approach. Immutable infrastructure is a model where components are replaced rather than changed, improving reliability and rollback capabilities.
- `Integration with Infrastructure as Code (IaC):` Packer integrates well with IaC tools like Terraform, enabling automated deployment and management of the infrastructure that runs the Packer-built images.
- `Efficiency in Development and Testing:` By creating standardized machine images, developers and QA teams can work in environments that closely mimic production, reducing the "works on my machine" problem.

## [Hashicorp Vagrant](https://developer.hashicorp.com/vagrant)
- Vagrant is the command line utility for managing the lifecycle of virtual machines
- Isolate dependencies and their configuration within a single disposable and consistent environment

#### Hashicorp Vagrant Benefits
- `Simplified Workflow:` Vagrant provides a simple and consistent workflow to create and manage virtualized development environments. This simplifies the process of configuring and sharing these environments among team members, regardless of the host operating system.
- `Easy Configuration:` Using a single, simple configuration file (Vagrantfile), you can define and manage all aspects of a VM, such as its network settings, shared folders, and software to install.
- `Provider Agnostic:` Vagrant works with multiple providers, such as VirtualBox, VMware, AWS, and more. This flexibility allows developers to test their applications across different environments with minimal changes.
Provisioning and Automation: Vagrant supports automatic provisioning with tools like shell scripts, Chef, Puppet, or Ansible, enabling the automated setup of the development environment with all necessary dependencies.
- `Integration with Development Tools:` Vagrant integrates seamlessly with popular development tools and IDEs, making it easier to adapt into existing development workflows.
- `Community and Ecosystem:` There's a large ecosystem around Vagrant, including publicly available boxes (pre-configured Vagrant environments), which accelerates the setup of development environments.

#### Bill of Materials (BOM)
- Install Packer [here](https://developer.hashicorp.com/packer/install)
- Install the Packer extension for VS Code [here](https://marketplace.visualstudio.com/items?itemName=4ops.packer)
- Install Vagrant [here](https://developer.hashicorp.com/vagrant/install?product_intent=vagrant)
- Install the Vagrant extension for VS Code [here](https://marketplace.visualstudio.com/items?itemName=marcostazi.VS-code-vagrantfile)
- Install Virtualbox [here](https://www.virtualbox.org/wiki/Downloads)
- Download Git [here](https://git-scm.com/downloads)
- Download Windows 10 ISO [here](https://www.microsoft.com/en-gb/software-download/windows10)
- Windows 10 specs, features and computer requirements [here](https://www.microsoft.com/en-us/windows/windows-10-specifications)
- Install Oscdimg.exe image creation tool [here](http://www.sevenforums.com/attachments/general-discussion/32382d1256189124-make-bootable-iso-student-d-l-oscdimg.zip)
- Oscdimg.exe image creation tool docs [here](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-vista/cc749036(v=ws.10)?redirectedfrom=MSDN)

#### Packer Notes
- Packer will be used to build the image whereas Vagrant will be used to deploy the image
- Packer requires the file extension `*.pkr.hcl` otherwise Packer will not recognise it
- Packer uses the exact same language as `Terraform` which is `HCL2`
- Packer supports many `plugins` just like `Terraform` uses `providers`
- Packer VirtualBox `plugin` [here](https://https://developer.hashicorp.com/packer/integrations/hashicorp/virtualbox/latest/components/builder/iso)
- Oscdimg.exe must be added to your windows path here `%USERPROFILE%\AppData\Local\Microsoft\WindowsApps`
- Oscdimg.exe is needed for the creation of an ISO for the `Autounattend.xml and PowerShell scripts` to be loaded for Windows automation
- Create a folder in the root of the repo called `image`
- Add the `Windows ISO` in the `image` folder and name it `win10.iso`

```
virtualbox-iso.virtualbox: Creating CD disk...
    virtualbox-iso.virtualbox: OSCDIMG 2.54 CD-ROM and DVD-ROM Premastering Utility
    virtualbox-iso.virtualbox: Copyright (C) Microsoft, 1993-2007. All rights reserved.
    virtualbox-iso.virtualbox: Licensed only for producing Microsoft authorized content.
    virtualbox-iso.virtualbox: Scanning source tree
    virtualbox-iso.virtualbox: Scanning source tree complete (7 files in 1 directories)
    virtualbox-iso.virtualbox: Computing directory information complete
    virtualbox-iso.virtualbox: Image file is 83968 bytes (before optimization)
    virtualbox-iso.virtualbox: Writing 7 files in 1 directories to C:\Users\tvl\AppData\Local\Temp\packer3495914453.iso
    virtualbox-iso.virtualbox: Storage optimization saved 0 files, 0 bytes (0% of image)
    virtualbox-iso.virtualbox: After optimization, image file is 83968 bytes
    virtualbox-iso.virtualbox: Done.
```

#### Commands
- Initialise a Packer project
```
packer init win10.pkr.hcl
```
- Packer validate the HCL2 syntax
```
packer validate win10.pkr.hcl
```
- Packer format the syntax to keep it tidy
```
packer fmt win10.pkr.hcl
```
- Packer build the image
```
packer build -force win10.pkr.hcl
```

#### Vagrant Notes
- Vagrant Box [here](https://app.vagrantup.com/sachajw/boxes/win10)
- Vagrant up in the root of the repo will deploy the virtual machine

```
vagrant up
```

- Vagrant file

```
Vagrant.configure("2") do |config|
  config.vm.box = "sachajw/win10"
  config.vm.box_version = "1.0.3"
end
```

## Setup

#### Autounattend.xml
- Windows auto configuration answer file

#### choco-pkgs.ps1
- Installs Chocolatey Windows Package Manager
- Installs Git
- Installs PowerShell 7
- Installs 7zip
- Installs Visual Studio Code

#### disable-screensaver.ps1
- Disables the screensaver

#### fixnetwork.ps1
- Set the network location to private

#### microsoft-update.ps1
- Configures Microsoft Updates