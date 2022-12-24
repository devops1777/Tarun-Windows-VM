terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.36.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "Tarun-VM" {
  name     = "Tarun-VM"
  location = "UK South"
}

resource "azurerm_virtual_network" "Tarun-VN" {
  name                = "Tarun-VN"
  location            = azurerm_resource_group.Tarun-VM.location
  resource_group_name = azurerm_resource_group.Tarun-VM.name
  address_space       = ["10.0.0.0/16"]

  depends_on = [
    azurerm_resource_group.Tarun-VM
  ]
}

resource "azurerm_subnet" "Tarun-SN" {
  name                = "Tarun-SN"
  resource_group_name = azurerm_resource_group.Tarun-VM.name
  virtual_network_name = azurerm_virtual_network.Tarun-VN.name
  address_prefixes      = ["10.0.2.0/24"]

  depends_on = [
    azurerm_virtual_network.Tarun-VN
  ]
}

resource "azurerm_network_interface" "Tarun-NI" {
  name                = "Tarun-NI"
  location            = azurerm_resource_group.Tarun-VM.location
  resource_group_name = azurerm_resource_group.Tarun-VM.name

  ip_configuration {
    name                          = "Tarun-IP"
    subnet_id                     = azurerm_subnet.Tarun-SN.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.Tarun-PIP.id
  }

  depends_on = [
    azurerm_subnet.Tarun-SN,
    azurerm_public_ip.Tarun-PIP
  ]
}

resource "azurerm_windows_virtual_machine" "Tarun-WVM" {
  name                = "Tarun-WVM"
  location            = azurerm_resource_group.Tarun-VM.location
  resource_group_name = azurerm_resource_group.Tarun-VM.name
  size                = "Standard_B1s"
  admin_username      = "tarunVM"
  admin_password      = "P@ssword1777"

  network_interface_ids = [
    azurerm_network_interface.Tarun-NI.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.Tarun-NI
  ]
}

resource "azurerm_public_ip" "Tarun-PIP" {
  name = "Tarun-PIP"
  resource_group_name = azurerm_resource_group.Tarun-VM.name
  location = azurerm_resource_group.Tarun-VM.location
  allocation_method = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_managed_disk" "Tarun-VM-SG" {
  name = "Tarun-VM-SG"
  resource_group_name = azurerm_resource_group.Tarun-VM.name
  location = azurerm_resource_group.Tarun-VM.location
  create_option = "Empty"
  storage_account_type = "Standard_LRS"
  disk_size_gb = 8
}

resource "azurerm_virtual_machine_data_disk_attachment" "Tarun-DA" {
  managed_disk_id = azurerm_managed_disk.Tarun-VM-SG.id
  virtual_machine_id = azurerm_windows_virtual_machine.Tarun-WVM.id    
  lun = "0"
  caching = "ReadWrite"
  
  depends_on = [
    azurerm_windows_virtual_machine.Tarun-WVM,
    azurerm_managed_disk.Tarun-VM-SG
  ]
}