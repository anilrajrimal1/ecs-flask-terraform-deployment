
# Flask Application Deployment to AWS EC2 using Terraform

This repository contains Infrastructure as Code (IaC) to deploy a simple Flask app on an AWS EC2 instance using Terraform. The configuration provisions network resources, security groups, and the EC2 instance required to host the Flask application.

## Table of Contents
- [Overview](#overview)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup and Usage](#setup-and-usage)
- [Configuration](#configuration)
- [Deployment](#deployment)
- [Accessing the Application](#accessing-the-application)
- [Clean Up](#clean-up)
- [Troubleshooting](#troubleshooting)

---

## Overview

This project sets up the infrastructure required to host a Flask application on AWS EC2. The Terraform scripts create:
- A custom VPC, subnet, and security group
- An Internet Gateway and associated route tables
- An EC2 instance configured for the Flask application

## Project Structure

```plaintext
.
├── flask_app
│   ├── app.py                   # Flask application code
│   └── templates
│       └── home.html            # HTML template for the Flask app
├── README.md                    # Documentation file
└── terraform_files
    ├── ec2.tf                   # EC2 instance configuration
    ├── internet-gateway.tf      # Internet gateway configuration
    ├── key_pair.tf              # Key pair configuration
    ├── outputs.tf               # Output values after resource creation
    ├── provider.tf              # AWS provider configuration
    ├── route-table-association.tf # Route table associations
    ├── route-table.tf           # Route table configuration
    ├── security-group.tf        # Security group for EC2 instance
    ├── subnet.tf                # Subnet configuration
    ├── terraform.tfstate        # Terraform state file
    ├── terraform.tfstate.backup # Backup of the state file
    ├── terraform.tfvars         # Variable values file
    ├── variables.tf             # Variable definitions
    └── vpc.tf                   # VPC configuration
```

## Prerequisites

- **AWS CLI**: [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) and configure it.
- **Terraform**: [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- **AWS Key Pair**: Ensure you have an SSH key pair in AWS, or Terraform can generate one.

```bash
aws configure
```

## Setup and Usage

### 1. Clone the Repository

```bash
git clone <repository-url>
cd terraform-aws/flask-ec2-deployment-terraform
```

### 2. Configure Variables

Edit `terraform_files/terraform.tfvars` to specify custom values for AWS region, VPC CIDR, or instance details if required. Alternatively, update `variables.tf` with any other necessary variables.

### 3. Flask Application Setup

The Flask app should be Dockerized or set up to run directly on EC2. Update `ec2.tf` with necessary startup scripts or `user_data` to start the Flask app on instance launch.

## Configuration

Key Terraform files for this deployment:
- **`vpc.tf`**: Defines the VPC and subnet configuration.
- **`ec2.tf`**: Provisions an EC2 instance and associates the application.
- **`security-group.tf`**: Configures security group rules for the EC2 instance.
- **`outputs.tf`**: Outputs critical information like the instance public IP after deployment.

## Deployment

1. **Initialize Terraform**

   ```bash
   cd terraform_files
   terraform init
   ```

2. **Plan Deployment**

   ```bash
   terraform plan
   ```

3. **Apply Configuration**

   ```bash
   terraform apply
   ```

   Confirm with `yes`. Terraform will output the instance’s public IP or DNS upon completion.

## Accessing the Application

Once deployed, access your Flask app using the public IP or DNS of the EC2 instance provided in the Terraform output.

```plaintext
http://<public-ip-or-dns>
```

## Clean Up

To delete all resources created by Terraform:

```bash
terraform destroy
```

Type `yes` when prompted to confirm resource deletion.

## Troubleshooting

- **SSH Connection Issues**: Ensure the security group allows SSH access (port 22).
- **Application Not Running**: Verify that the Flask application starts with the EC2 instance (check user data scripts).
- **Networking Issues**: Confirm the route tables, subnets, and security groups are correctly