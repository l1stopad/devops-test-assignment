# Terraform Infrastructure for WordPress Deployment

## 📌 Description
This project utilizes Terraform for automated WordPress deployment on AWS. It sets up:
- **VPC** (Virtual Private Cloud) with public and private subnets
- **EC2 instance** for hosting WordPress
- **RDS (MySQL)** in a private subnet
- **ElastiCache (Redis)** for caching
- **Security Groups** to secure resources
- **Scalability and High Availability** with infrastructure best practices

## 🛠 Configuration Options

### **1. `variables.tf` File**
The project supports customization via Terraform variables:

```hcl
variable "region" {
  description = "AWS region for deployment"
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr_1" {
  description = "CIDR block for first private subnet"
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_2" {
  description = "CIDR block for second private subnet"
  default     = "10.0.3.0/24"
}
```

### **2. `terraform.tfvars` File (Optional)**
You can override variables here:
```hcl
region = "eu-west-1"
vpc_cidr = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
private_subnet_cidr_1 = "10.0.2.0/24"
private_subnet_cidr_2 = "10.0.3.0/24"
```

### **3. Module Overview**
The project consists of the following main modules:
- `network.tf` – Creates VPC, subnets, Internet Gateway, and NAT Gateway
- `security_groups.tf` – Configures security access
- `ec2.tf` – Sets up the EC2 instance
- `rds.tf` – Creates MySQL RDS in a private subnet
- `redis.tf` – Deploys ElastiCache Redis
- `alb.tf` (optional) – Configures Application Load Balancer for high availability

## 🚀 Deployment
### **1. Initialize Terraform**
Before running, initialize Terraform:
```bash
terraform init
```

### **2. Validate Configuration**
```bash
terraform validate
terraform plan
```

### **3. Apply Deployment**
```bash
terraform apply -auto-approve
```

## 🔧 Accessing Servers
### **Connect via SSH**
1. **Manually add SSH key** to `~/.ssh/authorized_keys` on the EC2 instance.
2. **Connect using SSH:**
```bash
ssh -i ~/.ssh/id_rsa ubuntu@<EC2_Public_IP>
```

## 🐞 Troubleshooting Common Issues
### **1. RDS or ElastiCache Issues**
❌ *Error: "DBSubnetGroupAlreadyExists" or "CacheSubnetGroupAlreadyExists"*
✅ **Solution:** Manually delete the subnet group in AWS Console and re-run `terraform apply`.

### **2. Database Connection Error**
❌ *Error: "Error establishing a database connection"*
✅ **Solution:**
- Verify `wp-config.php` contains the correct `DB_HOST`, `DB_USER`, and `DB_PASSWORD`.
- Test connection manually:
```bash
mysql -h <RDS_ENDPOINT> -u <DB_USER> -p<DB_PASSWORD>
```

### **3. Redis Connection Fails**
❌ *Error: "Could not connect to Redis"*
✅ **Solution:**
- Test the connection manually:
```bash
redis-cli -h <REDIS_ENDPOINT> -p 6379 ping
```
- Ensure `WP_REDIS_HOST` and `WP_REDIS_PORT` are correctly set in `wp-config.php`.

### **4. SSH Connection Issues**
❌ *Error: "Permission denied (publickey)"*
✅ **Solution:**
- Add your public SSH key to `~/.ssh/authorized_keys`.
- Ensure the EC2 security group allows `SSH (22)` access.

### **5. Terraform State Issues**
❌ *Error: "resource already exists"*
✅ **Solution:**
- Run `terraform state list` to verify existing resources.
- If needed, manually remove problematic resources via AWS Console.
- Use `terraform destroy` to clean up before redeploying.

## 📎 Additional Enhancements
- **Application Load Balancer (ALB)** can be added for load balancing and fault tolerance.
- **Automated RDS Backups** can be set up using AWS Backup.
- **Scaling**: EC2 Auto Scaling Groups can be implemented for handling traffic spikes.

✅ **Done! Your WordPress is now automatically deployed on AWS with best DevOps practices! 🚀**

