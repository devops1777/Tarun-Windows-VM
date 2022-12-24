# Tarun-VM

Declare the Azure Resource Manager provider and specify the version to use
Create an Azure resource group
Create an Azure virtual network
Create a subnet within the virtual network
Create a network interface with an associated public IP address
Create a Windows virtual machine, attach the network interface and specify the OS disk settings
Create a public IP address and apply tags
Create a managed disk
Attach the managed disk to the virtual machine as a data disk
Create a security group and a rule within the security group
Associate the security group with the network interface of the virtual machine


Declare the trigger for the pipeline to run, in this case the master branch
Specify the pool to use for the pipeline, using the ubuntu-latest image
Add a step to run a one-line script that outputs "Hello, world!"
Add a step to run a multi-line script that outputs a message about adding other tasks to build, test, and deploy the project.

# Starter pipeline
# Start with a minimal pipeline that you can customize to build and deploy your code.
# Add steps that build, run tests, deploy, and more:
# https://aka.ms/yaml

trigger:
- master

pool:
  vmImage: ubuntu-latest

steps:
- script: echo Hello, world!
  displayName: 'Run a one-line script'

- script: |
    echo Add other tasks to build, test, and deploy your project.
    echo See https://aka.ms/yaml
  displayName: 'Run a multi-line script'
  
  
