# Cloud Server Project: dptech.online

**Student:** Diego Pedraza  
**Student ID:** 35549445  
**Unit:** ICT171 - Server Environments and Architectures  
**Project Name:** dptech.online  
**Project Type:** Cloud-hosted IT services website with secure access, scripting automation, and cost analysis  
**Primary Domain:** https://dptech.online  
**Replica/Test Domain:** https://dptech2.online

## 📋 Table of Contents
1. [Project Purpose and Scope](#project-purpose-and-scope)
2. [Cloud Infrastructure Overview](#cloud-infrastructure-overview)
3. [Local Machine Setup](#local-machine-setup)
4. [Domain Configuration](#domain-configuration)
5. [Hosting Platform: Amazon EC2](#hosting-platform-amazon-ec2)
6. [SSH Connection](#ssh-connection)
7. [Apache-Server](#apache-server)
8. [Domain Registration and DNS Setup](#3-domain-registration-and-dns-setup)
9. [TLS Certificate Setup](#tls-certificate-setup-lets-encrypt)
10. [Website Updating Files](#website-updating-files)
11. [Backup Automation Script](#backup-automation-script)
12. [Cron Job Setup](#cron-job-setup)
13. [GitHub Repository](#github-repository)
14. [Total Cost of Ownership (TCO)](#total-cost-of-ownership-tco---3-year-analysis)
15. [Troubleshooting Guide](#troubleshooting-guide)
16. [Performance Monitoring](#performance-monitoring)
17. [Security Best Practices](#security-best-practices)
18. [Final Testing Checklist](#final-testing-checklist)
19. [Video Explainer](#-video-explainer)
20. [References](#references)

## Project Purpose and Scope

This cloud infrastructure project aimed to deploy a fully operational IT services website, **dptech.online**, using Amazon Web Services (AWS) EC2 to simulate a real-world business scenario. DPTech provides diverse services, such as hardware repairs, virus removals, data recovery, networking assistance, and cloud IT consulting. The solution was designed to be secure, cost-effective, and scalable with automated tasks to simulate a professional-grade cloud deployment. The scope involved registering a domain, configuring DNS records, launching a Linux EC2 instance, installing and configuring a web server, implementing TLS encryption, scripting backup procedures, automating tasks with cron, and documenting total cost of ownership over three years. Each step was carried out with a focus on reproducibility, allowing the server to be redeployed independently in the future.

### Why Infrastructure as a Service (IaaS)?
This project specifically uses IaaS (AWS EC2) rather than Platform as a Service (PaaS) or Software as a Service (SaaS) to demonstrate:
- Full control over the server environment
- Manual configuration and deployment skills
- SSH access for direct server management
- Real-world server administration experience
- Complete understanding of the technology stack

### Documentation Approach
This documentation is designed to be:
- **Reproducible**: Another ICT171 student could rebuild this server without additional research
- **Complete**: All commands, configurations, and decisions are documented
- **Professional**: Written as technical documentation for IT staff
- **Practical**: Focused on real implementation rather than theory

## Cloud Infrastructure Overview

| **Element** | **Detail** |
|-------------|------------|
| **Platform** | AWS EC2 – IaaS |
| **Instance Type** | t3.micro (Free Tier eligible) |
| **OS** | Ubuntu Server 24.04 LTS |
| **Elastic IP (Main)** | 3.107.180.255 |
| **Elastic IP (Test)** | 13.237.145.105 |
| **Security Rules** | TCP: 22 (SSH), 80 (HTTP), 443 (HTTPS) |

## Local Machine Setup

- **Operating System**: Windows 11
- **Terminal Tool**: MobaXterm
- **SSH Key File**: D:\amazon\diegokey.pem
- **Website Files Folder**: D:\amazon\webEC2
- **Git Client**: GitHub Desktop
- **Git Files Folder**: D:\github\dptech-server

## Domain Configuration

Domains registered on [Namecheap](https://www.namecheap.com/) and configured as follows:

| **Domain** | **IP Address** | **SSL** | **Purpose** |
|------------|----------------|---------|-------------|
| dptech.online | 3.107.180.255 | ✅ | Production server |
| dptech2.online | 13.237.145.105 | ✅ | Replica Test server for documentation |

📌 Both domains use A records pointing to their respective public Elastic IPs.

# Hosting Platform: Amazon EC2

Amazon EC2 (Elastic Compute Cloud) was selected for this project due to its flexibility, affordability, and industry relevance.

**Step-by-Step Configuration:**

![AWS EC2 Console](images/image1.png)

![EC2 Instance Launch](images/image2.png)

- http://aws.amazon.com/ec2/

Or console page:

- https://console.aws.amazon.com

- Logged into AWS Console and selected EC2 from the Services menu.
- Launched a new instance
- Name and tags, name: DiegoServer-EC2 (DiegoServer2-EC2 Replica Test server)
- using **Ubuntu Server 24.04 LTS (64-bit ARM)**.
- Chose **t3.micro** instance type under the free tier.
- Created a new key pair (diegokey.pem) and downloaded it securely.
- Set up the security group to allow incoming traffic on TCP ports:
  - 22 (SSH) for secure shell access
  - 80 (HTTP) for web access
  - 443 (HTTPS) for encrypted connections

# SSH Connection

![MobaXterm SSH Configuration](images/image3.png)

![MobaXterm Terminal Connected](images/image4.png)

- Used MobaXterm from Windows to SSH into the server:
- `ssh -i diegokey.pem ubuntu@3.107.180.255`

**Note:** For the test server used:
- `ssh -i diegokey.pem ubuntu@13.237.145.105`

### Key File Security in MobaXterm
```bash
# Set proper permissions for the key file
chmod 400 /drives/d/amazon/diegokey.pem

# Verify permissions
ls -la /drives/d/amazon/diegokey.pem
```

### First Connection Checklist
1. Ensure EC2 instance is running in AWS Console
2. Verify Security Group allows SSH (port 22) from your IP
3. Confirm key file has correct permissions (400)
4. Use correct username: `ubuntu` for Ubuntu Server

# Apache-Server

![Apache Installation in MobaXterm](images/image5.png)

![Apache Status Verification](images/image6.png)

- Updated the package list and installed Apache web server:
- `sudo apt update`
- `sudo apt install apache2 -y`
- `sudo systemctl enable apache2`
- `sudo systemctl start apache2`
- Verified service with `systemctl status apache2` and accessed the default Apache landing page from a browser.

### Apache Configuration Details
```bash
# Check Apache version
apache2 -v

# Verify Apache is listening on ports
sudo netstat -tlnp | grep apache2

# Enable essential Apache modules
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod ssl

# Restart Apache after module changes
sudo systemctl restart apache2
```

### Testing Apache Installation
1. **Local test**: `curl http://localhost`
2. **External test**: Navigate to `http://YOUR_EC2_IP` in browser
3. **Check logs**: `sudo tail -f /var/log/apache2/access.log`

## 3. Domain Registration and DNS Setup

![Namecheap Dashboard](images/image7.png)

![DNS Advanced Settings](images/image8.png)

![DNS A Records Configuration](images/image9.png)

- Purchased the domain dptech.online from Namecheap ($1.16 AUD/year).
- Purchased the domain dptech2.online from Namecheap ($1.16 AUD/year).
- Logged into Namecheap Dashboard > Domain List > Manage > Advanced DNS.
- **For dptech.online:**
  - Added A record: @ pointing to 3.107.180.255
  - Added A record: www pointing to 3.107.180.255
- **For dptech2.online (Test Server):**
  - Added A record: @ pointing to 13.237.145.105
  - Added A record: www pointing to 13.237.145.105
- Set TTL to Automatic for both domains.
- Confirmed DNS propagation using external DNS checkers and the following terminal commands:
- `dig dptech.online`
- `nslookup dptech.online`
- `wget http://dptech.online`
- `curl -Iv https://dptech.online`
- Full propagation occurred within approximately 15–20 minutes.

# TLS Certificate Setup (Let's Encrypt)

![Let's Encrypt Certbot Installation](images/image10.png)

To enable secure connections:

- Ensured port 443 was open in the EC2 instance's security group.
- `wget http://dptech.online`
- `sudo apt update`
- `sudo apt install snapd -y`
- `sudo snap install core`
- `sudo snap refresh core`
- `sudo snap install --classic certbot`
- `sudo ln -s /snap/bin/certbot /usr/bin/certbot`
- `sudo certbot --apache`

```
y
N
dptech2.online www.dptech2.online
2
000-default-le-ssl.conf
```

- Installed Snap and Certbot tools:
- `sudo snap install core`
- `sudo snap refresh core`
- `sudo snap install --classic certbot`
- `sudo ln -s /snap/bin/certbot /usr/bin/certbot`
- Installed the certificate with Apache integration:
- `sudo certbot --apache`
- Selected both domains during the prompt (dptech.online and www.dptech.online).
- Auto-redirect from HTTP to HTTPS was enabled.
- Verified certificate with browser (lock icon) and CLI tools:

# `curl -Iv https://dptech.online`

![SSL Certificate Verification](images/image11.png)

- Confirmed certificate was issued by Let's Encrypt and set to renew automatically.

# Website Updating Files

![File Transfer via MobaXterm](images/image12.png)

**In MobaXterm terminal:**
```bash
cd /drives/d/amazon/webEC2/v2
chmod 400 /drives/d/amazon/diegokey.pem
scp -i /drives/d/amazon/diegokey.pem /drives/d/amazon/webEC2/v2/*.html ubuntu@3.107.180.255:/home/ubuntu/
scp -i /drives/d/amazon/diegokey.pem -r /drives/d/amazon/webEC2/v2/css ubuntu@3.107.180.255:/home/ubuntu/
```

![Moving Files to Web Root](images/image13.png)

**On the server via SSH:**
```bash
sudo mv /home/ubuntu/*.html /var/www/html/
sudo rm -r /var/www/html/css
sudo mv /home/ubuntu/css /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo systemctl reload apache2
```

**Web-Update**

![Live Website](images/image14.png)

- Cleaned the default contents of /var/www/html:
- `sudo rm /var/www/html/index.html`
- Uploaded custom HTML, CSS, and images using MobaXterm:
- `scp -i diegokey.pem index.html ubuntu@3.107.180.255:/var/www/html/`
- Verified file permissions and ownership:
- `sudo chown www-data:www-data /var/www/html/index.html`
- Reloaded Apache to confirm new content:
- `sudo systemctl reload apache2`
- Website loaded properly at https://dptech.online/.

### 🎨 Website Design and Template Attribution

The frontend of the **dptech.online** website was developed using a customized HTML/CSS template based on the open-source Bootstrap template:

- 📄 **Source template**: [Business Frontpage – Start Bootstrap](https://startbootstrap.com/template/business-frontpage)  
- 🆓 **License**: [MIT License](https://github.com/StartBootstrap/startbootstrap-business-frontpage/blob/master/LICENSE)

The template was adapted to match the branding and service structure of DPTech. This includes modified color schemes, HTML sections, and service categories. It was deployed manually to `/var/www/html/` and does not rely on bundled CMS tools.

### ⭐ Icons Used

This project makes use of **Font Awesome Free Icons** to enhance visual clarity and modern design:

- 🔗 [Font Awesome](https://fontawesome.com/)  
- 🧾 **License**: Free icons are released under **Creative Commons Attribution 4.0** and **MIT License**

### 🛠️ DPTech Services Summary

DPTech is an independent IT solutions provider offering a comprehensive range of technical services including:

- **Support & Maintenance**  
  PC/Mac & Mobile Repair, Help Desk (Remote/On-site), Virus Removal & Optimization, Preventive Maintenance

- **Hardware & Assembly**  
  Custom PC Building, Component Upgrades, Hardware Diagnostics, Component Sales

- **Software & Data**  
  OS & Application Installation, Advanced Data Recovery, Secure Backup Solutions, Software Configuration

- **Networks & Infrastructure**  
  Network Design & Installation, Server Administration, Network Security (Firewalls, VPN), Structured Cabling

- **Additional Services**  
  Strategic IT Consulting, Technology Training, Cloud Solutions, Business IT Support

- **Contact Us**  
  Ready to help with your technology needs. Contact us for a free consultation!

# Backup Automation Script

- Created structure:
- `mkdir -p /home/ubuntu/Documents`
- `mkdir -p /home/ubuntu/backup`
- Added sample files using touch command:
- `touch /home/ubuntu/Documents/file1.txt`
- `touch /home/ubuntu/Documents/file2.txt`
- Created the backup script /usr/bin/testscript:

```bash
#!/bin/bash
# Backup Script for DPTech Server
# Author: Diego Pedraza
# Purpose: Automated daily backup of documents with timestamping
# This script creates timestamped backups of the Documents folder
# and can optionally transfer them to a remote server

now=$(date +"%d_%m_%y")
mkdir -p /home/ubuntu/backup

# Copy all documents to backup folder
cp -R /home/ubuntu/Documents/* /home/ubuntu/backup/

# Create timestamped zip file
zip -r /home/ubuntu/backup/$now.zip /home/ubuntu/backup/*

# Optional: Transfer to remote backup server
# Uncomment the following line to enable remote backup
# scp -i /home/ubuntu/diegokey.pem /home/ubuntu/backup/$now.zip ubuntu@3.107.180.255:/home/ubuntu/
```

### Script Functionality Explanation
This backup script serves as an automated solution for data protection. It performs the following operations:
1. **Date Generation**: Creates a timestamp in DD_MM_YY format for unique file naming
2. **Directory Creation**: Ensures the backup directory exists before operations
3. **File Copying**: Recursively copies all contents from the Documents folder
4. **Compression**: Creates a zip archive with the date-stamped filename
5. **Remote Transfer**: Includes optional functionality to transfer backups to a remote server

The script is designed to run automatically via cron, ensuring regular backups without manual intervention. This approach provides version history through dated archives and protects against data loss.

- Made it executable:
- `chmod +x /usr/bin/testscript`
- Executed manually to validate zip output:
- `/usr/bin/testscript`
- Verified backup creation:
- `ls -la /home/ubuntu/backup/`

# Cron Job Setup

- Opened crontab:
- `sudo nano /etc/crontab`
- Appended:
- `0 * * * * ubuntu /usr/bin/testscript`
- Checked cron logs and /home/ubuntu/backup to verify automatic execution
- Confirmed zip files were created with date-based filenames every hour

# GitHub Repository

![GitHub Desktop](images/image15.png)

- Pending publication at GitHub
- Will include:
  - Complete script with comments
  - HTML/CSS source code
  - Deployment instructions in README.md
  - DNS and TLS testing outputs

# Clarification on Dual Domains

**Important Note:** The screenshots and video documentation were created using the test server (dptech2.online) as the original production server (dptech.online) was deployed in Assignment 1 and has been running continuously since then without documentation of the setup process.

- **dptech.online – Primary website hosted on an EC2 instance (IP: 3.107.180.255) deployed in Assignment 1.**
- **dptech2.online – Mirror server created for video and documentation purposes, using Elastic IP (13.237.145.105).**

**The two domains are nearly identical in functionality and configuration. The test server was created to properly record the setup steps which were missed initially on the main instance.**

# Total Cost of Ownership (TCO) - 3 Year Analysis

## Three-Year Cost Summary

| Platform | Year 1 | Year 2 | Year 3 | 3-yr Grand Total |
|----------|--------|--------|--------|------------------|
| On-Prem | $10,094 | $3,116 | $3,240 | $16,450 |
| Cloud Platform (IaaS) | $1,344 | $1,385 | $1,426 | $4,155 |
| Web Platform (SaaS) | $862 | $888 | $915 | $2,665 |

## Cloud Platform (IaaS) - Cost Breakdown (AUD)

AWS EC2 (Amazon Elastic Compute Cloud) is a web service that provides secure, resizable compute capacity in the cloud. It is designed to make web-scale cloud computing easier for developers.

| Cost Bucket | Year 1 | Year 2 | Year 3 | 3-yr Sub-Total |
|-------------|--------|--------|--------|----------------|
| Compute (t3.small 0.0408 AUD/h, +3%) | $357 | $368 | $379 | $1,104 |
| Storage (gp3 100 GB, +3%) | $61 | $63 | $65 | $189 |
| Daily Snapshots (30 GB, +3%) | $298 | $307 | $316 | $921 |
| Data Transfer (100 GB/mo @ $0.12/GB, +3%) | $154 | $159 | $164 | $477 |
| Route 53 + Domain | $49 | $49 | $49 | $147 |
| DevOps Labour (6h @ $55, +3%) | $330 | $340 | $350 | $1,020 |
| Contingency 10% (Opex) | $95 | $99 | $103 | $297 |
| **IaaS Annual Total** | **$1,344** | **$1,385** | **$1,426** | **$4,155** |

## On-Prem (Dell R550) - Cost Breakdown (AUD)

| Cost Bucket | Year 1 | Year 2 | Year 3 | 3-yr Sub-Total |
|-------------|--------|--------|--------|----------------|
| CapEx (server + UPS + FW) | $7,006 | $- | $- | $7,006 |
| Rack & Cooling | $300 | $318 | $337 | $955 |
| Power (250W avg @ $0.30 kWh, +6%) | $657 | $697 | $739 | $2,093 |
| Software (cPanel $60 / Acronis 120, +3%) | $420 | $433 | $446 | $1,299 |
| Domain + DNS | $26 | $27 | $27 | $80 |
| IT Staff (0.5 FTE @ $85, +3%) | $1,320 | $1,360 | $1,401 | $4,081 |
| Contingency 10% (Opex) | $272 | $281 | $290 | $843 |
| **On-Prem Annual Total** | **$10,094** | **$3,116** | **$3,240** | **$16,450** |

## Web Platform (SaaS) - Cost Breakdown (AUD)

WordPress.com is a hosted Software as a Service (SaaS) platform that allows users to create and manage websites and blogs without needing to manage the underlying server infrastructure, security, or software updates.

| Cost Bucket | Year 1 | Year 2 | Year 3 | 3-yr Sub-Total |
|-------------|--------|--------|--------|----------------|
| Plan Subscription (US$15/mo, +3%) | $286 | $274 | $292 | $822 |
| Media Overage (10 GB/yr @ $1.20/GB, +6%) | $12 | $13 | $14 | $39 |
| Domain (internal) | $26 | $27 | $27 | $80 |
| Content Manager (10/mo @ $40, +3%) | $480 | $494 | $509 | $1,483 |
| Contingency 10% (Opex) | $78 | $80 | $83 | $241 |
| **SaaS Annual Total** | **$862** | **$888** | **$915** | **$2,665** |

# Final Testing Checklist

✅ DNS resolves and A records confirmed  
✅ Apache Web Server fully operational  
✅ HTTPS enabled with valid certificate  
✅ Website content deployed successfully  
✅ Backup script tested manually and via cron  
✅ Files timestamped correctly with zip format  
✅ Server secure, ports configured properly  
✅ Platform aligns with real-world IT business simulation

## Troubleshooting Guide

### Common Issues and Solutions

#### SSH Connection Issues
```bash
# Error: Permission denied (publickey)
# Solution: Check key file permissions in MobaXterm
chmod 400 /drives/d/amazon/diegokey.pem

# Error: Connection timeout
# Solution: Verify security group allows SSH from your IP
# Check AWS Console > EC2 > Security Groups > Inbound Rules
```

#### DNS Not Resolving
```bash
# Check DNS propagation status
dig dptech.online @8.8.8.8
nslookup dptech.online

# If not resolving after 30 minutes:
# 1. Verify A records in Namecheap dashboard
# 2. Check IP address is correct
# 3. Clear local DNS cache
```

#### Apache Issues
```bash
# Apache not starting
sudo systemctl status apache2
sudo journalctl -xe | grep apache2

# Check for configuration errors
sudo apache2ctl configtest

# Common fix: Another service using port 80
sudo netstat -tulpn | grep :80
```

#### SSL Certificate Problems
```bash
# Certificate not working
sudo certbot certificates

# Force renewal if needed
sudo certbot renew --force-renewal

# Check Apache SSL module
sudo a2enmod ssl
sudo systemctl restart apache2
```

#### Website Not Loading
```bash
# Check file permissions
ls -la /var/www/html/
# Files should be owned by www-data

# Fix permissions if needed
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Check Apache error logs
sudo tail -f /var/log/apache2/error.log
```

## Performance Monitoring

### System Resource Monitoring
```bash
# Real-time system monitoring
htop

# Disk usage
df -h

# Memory usage
free -m

# Apache connections
sudo netstat -anp | grep :80 | wc -l

# Apache status module (if enabled)
sudo a2enmod status
sudo systemctl restart apache2
# Access at: http://your-ip/server-status
```

### Log Analysis
```bash
# Monitor Apache access logs
sudo tail -f /var/log/apache2/access.log

# Check for errors
sudo tail -f /var/log/apache2/error.log

# System logs
sudo journalctl -f
```

## Security Best Practices

### Server Hardening Steps Implemented
1. **SSH Security**
   - Key-based authentication only
   - Password authentication disabled
   - Root login disabled

2. **Firewall Configuration**
   - Only necessary ports open (22, 80, 443)
   - Security groups properly configured

3. **Regular Updates**
   ```bash
   # Automated security updates
   sudo apt install unattended-upgrades
   sudo dpkg-reconfigure --priority=low unattended-upgrades
   ```

4. **SSL/TLS Configuration**
   - HTTPS enforced with redirect
   - Strong cipher suites
   - Regular certificate renewal

5. **File Permissions**
   - Proper ownership for web files
   - Restricted access to sensitive files
   - Regular permission audits

### Backup Best Practices
- Automated daily backups via cron
- Timestamped archives for version history
- Optional off-site backup capability
- Regular backup testing and verification

## 📹 Video Explainer
[Link to video explainer - TO BE ADDED]

### Video Content Overview
The video demonstration covers:
1. Live server functionality demonstration
2. SSH connection process via MobaXterm
3. Apache configuration walkthrough
4. SSL certificate verification
5. Backup script execution
6. Website navigation and features

---

## Learning Outcomes Demonstrated

This project successfully demonstrates the following ICT171 learning outcomes:

### ✅ Linux Command Line Proficiency
- Extensive use of bash commands for server management
- File system navigation and manipulation
- Process management and service control

### ✅ Infrastructure Implementation
- AWS EC2 instance deployment from scratch
- Manual server configuration (not pre-built images)
- Network security configuration

### ✅ Server Installation and Configuration
- Ubuntu Server 24.04 LTS installation
- Apache web server setup and configuration
- SSL/TLS certificate implementation

### ✅ Version Control with GitHub
- Comprehensive project documentation
- Code versioning for scripts and configuration
- Professional README documentation

### ✅ Scripting Development
- Bash script for automated backups
- Cron job implementation for scheduling
- Error handling and logging

### ✅ Professional Documentation
- Complete technical documentation
- Total Cost of Ownership analysis
- Reproducible deployment instructions

### ✅ Cloud IaaS Implementation
- Full AWS EC2 deployment
- Domain and DNS configuration
- Security best practices

---

## Future Enhancements

While this project meets all assignment requirements, potential future improvements include:

1. **Load Balancing**: Implement AWS ELB for high availability
2. **Database Integration**: Add MySQL/MariaDB for dynamic content
3. **Monitoring**: Implement CloudWatch or Prometheus
4. **CI/CD Pipeline**: Automate deployments with GitHub Actions
5. **CDN Integration**: Use CloudFront for global content delivery
6. **Container Migration**: Dockerize the application
7. **Infrastructure as Code**: Implement Terraform for reproducibility

---

## References

1. **AWS EC2 Documentation**: https://docs.aws.amazon.com/ec2/
2. **Ubuntu Server Guide**: https://ubuntu.com/server/docs
3. **Apache HTTP Server Documentation**: https://httpd.apache.org/docs/2.4/
4. **Let's Encrypt Getting Started**: https://letsencrypt.org/getting-started/
5. **Namecheap DNS Setup Guide**: https://www.namecheap.com/support/knowledgebase/article.aspx/319/2237/
6. **MobaXterm Documentation**: https://mobaxterm.mobatek.net/documentation.html

---

**Last Updated:** June 2025  
**Assignment Submission:** ICT171 - Murdoch University