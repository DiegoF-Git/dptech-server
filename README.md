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

## 🏩 Infrastructure Details

* **Cloud Provider:** Amazon Web Services (AWS) - EC2 (Elastic Compute Cloud)
* **Instance:** Ubuntu 24.04 LTS, t3.micro, gp3 30 GB SSD (Asia Pacific - Sydney)
* **Security Group:** TCP Ports 22, 80, 443 opened
* **Elastic IP:** 3.107.180.255 (original) and new static IP for demo server
* **Domain:** Registered via Namecheap - `dptech.online` and demo domain `dptech2.online`
* **DNS Records:** A records pointing to the EC2 IP
* **TLS Certificate:** Let’s Encrypt via Certbot (Snap-based installation)
* **Web Server:** Apache2

---

## 📊 Step-by-Step Summary

### 1. Amazon EC2 Setup

* Logged into AWS Console and launched Ubuntu 24.04 LTS on t3.micro
* Created key pair `diegokey.pem` (reused for both original and demo instances)
* Configured security group to open ports 22, 80, and 443
* Allocated and associated Elastic IP to demo server
* Used MobaXterm to SSH into the server:

```bash
ssh -i D:\amazon\diegokey.pem ubuntu@<Your-Elastic-IP>
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

* Purchased `dptech.online` and `dptech2.online` from Namecheap
* Configured A records to point to EC2 Elastic IP
* Verified DNS:

```bash
ping dptech2.online
nslookup dptech2.online
dig dptech2.online
wget http://dptech2.online
```

### 3. TLS Certificate with Certbot (Snap-based)

* Opened port 443 in AWS Security Group
* Installed Certbot via Snap:

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

* Verified HTTPS and redirect:

```bash
curl -Iv https://dptech2.online
```

### 4. Website Deployment

* Removed default index:

```bash
sudo rm /var/www/html/index.html
```

* Uploaded content with MobaXterm:

```bash
scp -i diegokey.pem *.html *.css ubuntu@<Elastic-IP>:/var/www/html/
```

* Adjusted permissions:

```bash
sudo chown -R www-data:www-data /var/www/html/*
sudo systemctl reload apache2
```

* Site files deployed:

  * `index.html`, `services.html`, `about.html`, `contact.html`, `style.css`

### 5. Backup Script

* Created script `/usr/bin/testscript` to zip backup files
* Used cron to run hourly
* Manually tested script

---

## 🌐 Website Files

```
.
├── index.html         # Homepage
├── services.html      # IT service descriptions
├── about.html         # Company info, Project Proposal & Licence Rationale
├── contact.html       # Contact form and info
└── style.css          # Main stylesheet
```

---

## 🌐 TCO Analysis Summary (3 Years)

| Platform           | Year 1   | Year 2  | Year 3  | Total    |
| ------------------ | -------- | ------- | ------- | -------- |
| **On-Prem**        | \$10,094 | \$3,116 | \$3,240 | \$16,450 |
| **AWS EC2 (IaaS)** | \$1,344  | \$1,385 | \$1,426 | \$4,155  |
| **WP.com (SaaS)**  | \$862    | \$888   | \$915   | \$2,665  |

---

## 🚀 GitHub Deployment

Repo URL: [https://github.com/DiegoF-Git/dptech-server](https://github.com/DiegoF-Git/dptech-server)

Includes:

* HTML/CSS website files (v1 and v2)
* Updated structure (added demo domain and Elastic IP)
* Documentation built iteratively
* TLS and DNS verified on both domains

---

## 🎮 Video Recording Notes

* Separate EC2 instance created with Elastic IP for illustration
* OBS Studio used to record entire process
* Justification provided for having two environments (production & demo)

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
* [x] Elastic IP used in demo instance
* [x] Documentation and GitHub iteratively updated

---

## 🔮 Future Improvements

* Add CloudFront for CDN
* Backup to AWS S3
* Automate snapshot scheduling
* Monitor with AWS CloudWatch & Budgets

---
