# dptech-server

Cloud infrastructure project for [dptech.online](https://dptech.online) hosted on AWS EC2.
This repository contains documentation, automation scripts, and configuration used to deploy and manage the production server for DP IT Technology.

## 📌 Overview

DPTech is a small IT service business offering:

* Hardware Repair & Diagnostics
* Malware Removal & OS Optimization
* Network Setup, Wi-Fi & Security
* Cloud Solutions, Training, and Help Desk

The goal of this project was to host the website securely and professionally using Amazon EC2, enabling full control over the environment and scalability for future services.

## 🏧 Infrastructure

* **Cloud Provider:** AWS (Amazon EC2)
* **OS:** Ubuntu 24.04 LTS
* **Web Server:** Apache2
* **SSL/TLS:** Let’s Encrypt (Certbot)
* **Domain:** [dptech.online](https://dptech.online) (Namecheap)
* **DNS:** A record pointing to public IP `3.107.180.255`
* **Security Ports:** 22, 80, 443

## 🗂️ Repository Structure

```
├── backup_script.sh       # Bash script for automated backups
├── README.md              # Project summary and technical overview
├── LICENSE                # MIT License
└── Cloud_Server_Project.docx  # Detailed documentation of the setup
```

## 🔐 SSL Certificate

Issued via Let's Encrypt with Certbot, ensuring secure HTTPS access.

## 🔄 Backup Automation

A scheduled cron job runs an hourly backup script that zips the `/home/ubuntu/Documents` directory and stores it in `/home/ubuntu/backup` using the current date as the filename.

## ⏱️ Cron Setup

Crontab entry:

```
0 * * * * ubuntu /usr/bin/testscript
```

## 💻 How to Use

Clone the repository:

```bash
git clone https://github.com/DiegoF-Git/dptech-server.git
```

Modify or test the backup script locally:

```bash
chmod +x testscript
./testscript
```

## 🧪 Project Status

✅ EC2 setup
✅ Domain + DNS linked
✅ Apache + TLS (Let's Encrypt)
✅ Backup + Cron working
✅ GitHub integrated

📵 *Video walkthrough coming soon*

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
