# #Terraform # Window Server 2019 # Virtual Machine # Virtual Network # Subnet # Public IP # Managed Disk # Data Disk # Security Group # Azure Devops # GIT Repo # Pipeline

1. Declare the Azure Resource Manager provider and specify the version to use
2. Create an Azure resource group
3. Create an Azure virtual network
4. Create a subnet within the virtual network
5. Create a network interface with an associated public IP address
6. Create a Windows virtual machine, attach the network interface and specify the OS disk settings
7. Create a public IP address and apply tags
8. Create a managed disk
9. Attach the managed disk to the virtual machine as a data disk
10. Create a security group and a rule within the security group
11. Associate the security group with the network interface of the virtual machine

# Pipeline

- Declare the trigger for the pipeline to run, in this case the master branch
- Specify the pool to use for the pipeline, using the ubuntu-latest image
- Add a step to run a one-line script that outputs "Hello, world!"
- Add a step to run a multi-line script that outputs a message about adding other tasks to build, test, and deploy the project.

- Starter pipeline
- Start with a minimal pipeline that you can customize to build and deploy your code.
- Add steps that build, run tests, deploy, and more:
- https://aka.ms/yaml

- trigger:
  - - master

- pool:
  - vmImage: ubuntu-latest

- steps:
  - - script: echo Hello, world!
   - displayName: 'Run a one-line script'

- script: |
   - echo Add other tasks to build, test, and deploy your project.
   - echo See https://aka.ms/yaml
   - displayName: 'Run a multi-line script'
  
  
