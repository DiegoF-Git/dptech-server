# dptech-server

Cloud infrastructure project for [dptech.online](https://dptech.online) hosted on AWS EC2.
This repository contains documentation, automation scripts, deployment details, and configuration for the dptech.online production server.

---

## 📀 Overview

**DPTech** is an IT services business offering:

* Hardware Repair & Diagnostics
* Malware Removal & OS Optimization
* Network Setup, Wi-Fi & Security
* Cloud Solutions, Training, and Help Desk

The purpose of this project was to simulate a real-world deployment using Amazon EC2, delivering a secure, scalable infrastructure for a tech support business. It includes end-to-end implementation from cloud setup to domain registration, DNS, TLS encryption, automation, and cost analysis.

---

## 🏛️ Infrastructure Details

* **Cloud Provider:** Amazon Web Services (AWS) - EC2 (Elastic Compute Cloud)
* **Instance:** Ubuntu 24.04 LTS, t3.micro, gp3 30 GB SSD (Asia Pacific - Sydney)
* **Security Group:** TCP Ports 22, 80, 443 opened
* **Elastic IP:** 3.107.180.255
* **Domain:** Registered via Namecheap - `dptech.online`
* **DNS Records:** A records pointing to the EC2 IP
* **TLS Certificate:** Let’s Encrypt via Certbot
* **Web Server:** Apache2

---

## 📊 Step-by-Step Summary

### 1. Amazon EC2 Setup

* Logged into AWS Console and launched Ubuntu 24.04 LTS on t3.micro
* Created key pair `diegokey.pem`
* Configured security group to open ports 22, 80, and 443
* Allocated and associated an Elastic IP
* Used SSH from Windows Terminal:

```bash
ssh -i diegokey.pem ubuntu@3.107.180.255
```

* Installed Apache:

```bash
sudo apt update
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
```

* Verified Apache status and default page

### 2. Domain Registration & DNS

* Purchased `dptech.online` from Namecheap
* Configured A records (@ and www) to point to Elastic IP
* Verified DNS with:

```bash
dig dptech.online
nslookup dptech.online
ping dptech.online
wget http://dptech.online
```

### 3. TLS Certificate with Certbot

* Opened port 443 in AWS
* Installed Snap and Certbot:

```bash
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```

* Generated certificate:

```bash
sudo certbot --apache
```

* Enabled HTTP to HTTPS redirect and confirmed via browser and:

```bash
curl -Iv https://dptech.online
```

### 4. Website Deployment

* Removed default index:

```bash
sudo rm /var/www/html/index.html
```

* Uploaded custom content via SCP:

```bash
scp -i diegokey.pem index.html ubuntu@3.107.180.255:/var/www/html/
```

* Adjusted permissions:

```bash
sudo chown www-data:www-data /var/www/html/index.html
sudo systemctl reload apache2
```

### 5. Backup Script

* Created folder structure and files:

```bash
mkdir -p /home/ubuntu/Documents
mkdir -p /home/ubuntu/backup
touch /home/ubuntu/Documents/file1.txt
touch /home/ubuntu/Documents/file2.txt
```

* Created script `/usr/bin/testscript`:

```bash
#!/bin/bash
now=$(date +"%d_%m_%y")
mkdir -p /home/ubuntu/backup
cp -R /home/ubuntu/Documents/* /home/ubuntu/backup/
zip -r /home/ubuntu/backup/$now.zip /home/ubuntu/backup/*
scp -i /home/ubuntu/diegokey.pem /home/ubuntu/backup/$now.zip ubuntu@3.107.180.255:/home/ubuntu/
```

* Gave permissions:

```bash
chmod +x /usr/bin/testscript
```

* Tested manually: `/usr/bin/testscript`

### 6. Cron Job Setup

* Edited crontab:

```bash
sudo nano /etc/crontab
```

* Added line:

```bash
0 * * * * ubuntu /usr/bin/testscript
```

* Confirmed automation in logs and verified zip files

---

## 📑 Files in This Repo

```
.
├── backup_script.sh         # Bash script for automated backups
├── Cloud_Server_Project.docx  # Project documentation
├── LICENSE                  # MIT License
├── README.md                # This overview
```

---

## 🌐 TCO Analysis Summary (3 Years)

| Platform           | Year 1   | Year 2  | Year 3  | Total    |
| ------------------ | -------- | ------- | ------- | -------- |
| **On-Prem**        | \$10,094 | \$3,116 | \$3,240 | \$16,450 |
| **AWS EC2 (IaaS)** | \$1,344  | \$1,385 | \$1,426 | \$4,155  |
| **WP.com (SaaS)**  | \$862    | \$888   | \$915   | \$2,665  |

AWS EC2 was selected for its flexibility, cost savings, root access, and alignment with industry standards.

---

## 🚀 GitHub Deployment

Repo URL: [https://github.com/DiegoF-Git/dptech-server](https://github.com/DiegoF-Git/dptech-server)

Includes:

* Source code for automation
* HTML/CSS assets
* Deployment instructions
* TLS verification logs

---

## 📚 Author

**Name:** Diego Pedraza
**Student ID:** 35549445
**Unit:** ICT171 - Server Environments and Architectures

---

## ✅ Final Testing Checklist

* [x] DNS resolves and A records confirmed
* [x] Apache Web Server fully operational
* [x] HTTPS enabled with valid certificate
* [x] Website content deployed successfully
* [x] Backup script tested manually and via cron
* [x] Files timestamped correctly in zip format
* [x] Server secure with correct ports
* [x] Deployment simulates a real-world business scenario

---

## 🔮 Future Improvements

* Add CloudFront for CDN
* Backup to AWS S3
* Automate snapshot scheduling
* Monitor with AWS CloudWatch & Budgets

---
