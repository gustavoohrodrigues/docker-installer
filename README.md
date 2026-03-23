# 🐳 Docker Installation Script

A Bash-based automation tool designed to simplify Docker installation on Linux systems.

This project provides **automated, production-ready scripts** to install Docker on:

- Debian-based distributions (Ubuntu, Debian)
- RHEL-based distributions (CentOS, Rocky, AlmaLinux)

The goal is to provide a **fast, reliable, and repeatable installation process** for SysAdmins, DevOps engineers, and NOC/SOC teams.

---

## 👤 Author

**Gustavo Henrique Rodrigues**  
SysAdmin – NOC Engineer  

🔗 LinkedIn  
https://www.linkedin.com/in/gustavo-henrique-rodrigues-3070a5260  

---

## 🚀 Features

- Automated Docker installation
- Support for Debian-like and RHEL-like systems
- Official Docker repository configuration
- GPG key management
- Service auto-start and enable
- Validation after installation
- Interactive execution (optional menu)
- Clean and reproducible setup
- Production-ready scripts

---

## 📦 Requirements

### Debian-based systems:
- Ubuntu 20.04+
- Debian 11+

### RHEL-based systems:
- CentOS 8+
- Rocky Linux
- AlmaLinux

### Required tools:
- bash
- curl
- gnupg
- lsb-release (Debian-based)
- dnf (RHEL-based)

---

## ⚙️ Installation

### 1. Clone the repository

```bash
git clone https://github.com/gustavoohrodrigues/docker-install.git
cd docker-install
