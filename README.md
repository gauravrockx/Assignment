**Title**: Assignment to create roubust infrastructure for a new web application on Azure with help of Terraform.

**Description**: There are total 3 child modules used in this configuration.

- **Child Modules**:- Module 1, Module 2 & Module 3 will work as Child Module.

- _Module 1: Virtual Network_

This Virtual Network consists for two Subnets
- SubnetA :- SubnetA will be used with virtual machine scales sets (Backend Pools)
- SubnetB :- SubnetB will be used with Postgre SQL Database

- _Module 2: Virtual Machine Scale Sets & Public Load Balancer_

Virtual Machine Scale Set(VMSS) will perform the scalling on Virtual Machines and will connect from SubnetA.

Public Load balancer will balance the load as per load balancing rules.
Public IP address will be used by frontend IP address in Load Balancer.

- _Module 3: Postgre SQL Database_

Postgre SQL Database will connect from SubnetB and host the database.


- **Root Module**:- The exact values will be defined in root module and the child modules will be called from here.

- _main.tf_

- **How to run the code**:-

Open the folder project in Visual Basic Code 
Open the terminal and run below command to check the infrastructure 

**terraform plan -out main.tfplan**

It will show the no. of resources will be created on Azure, verify the resources and run below command if output is satisfactory.

Now run **terraform apply main.tfplan**

It will successfully create all the resources which is showed in terraform plan command.
