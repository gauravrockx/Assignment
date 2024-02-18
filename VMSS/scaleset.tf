#Public IP Configuration for VMSS Frontend IP

resource "azurerm_public_ip" "loadpubip" {
  name                = "load-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku = "Standard"
  tags = var.tags
}

# Public Load Balancer

resource "azurerm_lb" "loadbalancer" {
  name                = "lb-test"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku = "Standard"
  tags = var.tags

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.loadpubip.id
  }
}

# Load Balancing Rule

resource "azurerm_lb_rule" "lbrule" {
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
  probe_id = azurerm_lb_probe.example.id

  depends_on = [ azurerm_lb.loadbalancer,azurerm_public_ip.loadpubip ]
}

# Backend pools configuration 

resource "azurerm_lb_backend_address_pool" "bpepool" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "BackEndAddressPool"
  depends_on = [ azurerm_lb.loadbalancer ]
}

# NAT Rule on LB

resource "azurerm_lb_nat_pool" "lbnatpool" {
  resource_group_name            = "test-rg"
  name                           = "ssh"
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

# Health Probe

resource "azurerm_lb_probe" "example" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "http-probe"
  protocol        = "Http"
  request_path    = "/health"
  port            = 8080
}

# Virtual Machine Scale Set Configuration

resource "azurerm_linux_virtual_machine_scale_set" "scaleset" {
  name                = var.scaleset_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard_F2"
  instances           = 2
  admin_username      = "adminuser"
  admin_password      = "Password@123"
  disable_password_authentication = "false"
  upgrade_mode =  "Automatic"

os_disk {
  caching = "ReadWrite"
  storage_account_type = "Standard_LRS"
}

 source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  network_interface {
    name    = "scaleset-interface"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      load_balancer_inbound_nat_rules_ids =    [azurerm_lb_nat_pool.lbnatpool.id]
    }
  }
  depends_on = [ var.resource_group_name ]
 
  tags = var.tags
  
}
