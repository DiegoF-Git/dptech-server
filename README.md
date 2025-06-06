# dptech.online – Server Deployment Documentation (Assignment 2)

---

**Student Name:** Diego Pedraza
**Student ID:** 35549445
**Unit:** ICT171 – Introduction to Server Environments and Architectures
**Assignment:** Part B – Server Deployment and Documentation
**Submission Date:** 9th June 2025

---

## 🌐 Deployed Website

**Main Domain:** [https://www.dptech.online](https://www.dptech.online)
**Backup/Video Recording Domain:** [https://www.dptech2.online](https://www.dptech2.online)

These sites are hosted on separate EC2 instances and replicate the same environment for demonstration and documentation purposes.

---

## ✅ Purpose of this Repository

This repository documents the full process of deploying a secure web server on AWS EC2, including DNS configuration, HTTPS setup with TLS, and file transfer. It includes video recordings, screenshots, and written explanations to ensure the process can be replicated within a few hours if needed.

---

## 📁 Repository Structure

```
├── README.md
├── /screenshots       <- Visual evidence from EC2, domain setup, TLS, and file transfer
├── /scripts           <- Bash or server configuration scripts (if any used)
├── /html-files        <- Final website HTML/CSS files
└── /video             <- Final walkthrough recording
```

---

## 🚀 EC2 Instance Details

| Detail        | Information                   |
| ------------- | ----------------------------- |
| Region        | ap-southeast-2 (Sydney)       |
| OS            | Ubuntu Server 22.04 LTS       |
| Instance Type | t2.micro (Free Tier)          |
| Elastic IP    | Enabled (dptech2.online only) |
| Apache        | Installed and enabled         |
| Certbot/TLS   | Configured via Let's Encrypt  |

---

## 📝 Steps Completed

1. Created EC2 instance on AWS.
2. Created and configured a new key pair (`diegokey.pem`).
3. Assigned a security group (port 22, 80, 443 open).
4. Connected to the instance using **MobaXterm**.
5. Installed Apache2 and enabled the service:

   ```bash
   sudo apt update && sudo apt install apache2 -y
   sudo systemctl enable apache2
   sudo systemctl start apache2
   ```
6. Configured Elastic IP (for dptech2.online).
7. Registered domain via Namecheap (`dptech2.online`).
8. Updated domain DNS records (A record to Elastic IP).
9. Used `wget` and `curl` to verify site reachability:

   ```bash
   wget http://dptech2.online
   curl -Iv https://dptech2.online
   ```
10. Installed Certbot for TLS:

    ```bash
    sudo apt install certbot python3-certbot-apache -y
    sudo certbot --apache
    ```
11. Deployed HTML, CSS files using `scp` and/or `MobaXterm` drag-drop:

    ```bash
    scp -i /path/to/diegokey.pem -r ./html-files/* ubuntu@<Elastic-IP>:/var/www/html/
    ```
12. Verified web structure and HTTPS security lock.
13. Recorded video walkthrough and screenshots.

---

## 🛠 Commands Used Frequently

* SSH Access:

  ```bash
  ssh -i "/path/to/diegokey.pem" ubuntu@<Elastic-IP>
  ```
* Change file permissions (for .pem):

  ```bash
  chmod 400 /path/to/diegokey.pem
  ```
* Upload files to server:

  ```bash
  scp -i /path/to/diegokey.pem -r ./html-files/* ubuntu@<Elastic-IP>:/var/www/html/
  ```

---

## 🎬 Video Documentation

All core steps above were recorded using OBS.
The video includes:

* EC2 creation & connection
* Apache + Certbot setup
* Domain linking
* File uploads
* HTTPS verification

👉 \[Link to Video Walkthrough] (to be added)

---

## 🔁 Clarification on Dual Domains

* **dptech.online** – Primary website hosted on an EC2 instance **without Elastic IP** (IP: 3.107.180.255).
* **dptech2.online** – Mirror server created for video and documentation purposes, using Elastic IP.

The two domains are nearly identical in functionality and configuration. The backup was created to properly record the setup steps which were missed initially on the main instance.

---

## 📌 Notes

* All documentation is based on **real AWS deployment**.
* Steps were verified live during video capture.
* Screenshots are stored in the `screenshots/` folder.
* This guide enables full reconstruction within **2 hours** if needed.

---

## 📅 Progress Log (Simulated Commits)

* ✅ Initial commit: project setup and purpose documentation
* ✅ Added EC2 launch and key pair creation steps
* ✅ Included Apache installation and firewall config
* ✅ Documented Elastic IP and DNS setup via Namecheap
* ✅ Wrote TLS configuration steps with Certbot
* ✅ Transferred website files and verified structure
* ✅ Linked domains and tested HTTP/S connectivity
* ✅ Added walkthrough video section
* ✅ Clarified use of dual domains for academic transparency
* ✅ Final polishing of README formatting and clarity

---

*Thank you for reviewing my submission!*
