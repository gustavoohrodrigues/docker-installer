🐳 Docker Installation Script

A Bash-based automation tool designed to simplify Docker installation on Linux systems.

This project provides automated, production-ready scripts to install Docker on:

Debian-based distributions (Ubuntu, Debian)
RHEL-based distributions (CentOS, Rocky, AlmaLinux)

The goal is to provide a fast, reliable, and repeatable installation process for SysAdmins, DevOps engineers, and NOC/SOC teams.

👤 Author

Gustavo Henrique Rodrigues
SysAdmin – NOC Engineer

🔗 LinkedIn
https://www.linkedin.com/in/gustavo-henrique-rodrigues-3070a5260

🚀 Features
Automated Docker installation
Support for Debian-like and RHEL-like systems
Official Docker repository configuration
GPG key management
Service auto-start and enable
Validation after installation
Interactive execution (optional menu)
Clean and reproducible setup
Production-ready scripts
📦 Requirements
Debian-based systems:
Ubuntu 20.04+
Debian 11+
RHEL-based systems:
CentOS 8+
Rocky Linux
AlmaLinux
Required tools:
bash
curl
gnupg
lsb-release (Debian-based)
dnf (RHEL-based)
⚙️ Installation
1. Clone the repository
git clone https://github.com/gustavoohrodrigues/docker-install.git
cd docker-install
2. Run the script
Debian / Ubuntu
sudo ./docker-install.sh
RHEL / CentOS / Rocky / AlmaLinux
sudo ./docker-install-rhel.sh
🧠 What the script does
Debian-based
Updates system packages
Installs required dependencies
Adds Docker GPG key
Configures official Docker repository
Installs Docker Engine and CLI
Enables and starts Docker service
Validates installation
RHEL-based
Removes old Docker versions
Adds official Docker repository
Installs Docker Engine
Enables and starts Docker
Validates installation
📋 Menu (Interactive Mode)
1) Install Docker
2) Exit
✅ Validation

After installation, the script runs:

docker system info

If successful, Docker is ready to use.

🔐 Post-install (Optional)

Run Docker without sudo:

sudo usermod -aG docker $USER

Then re-login:

newgrp docker
⚠️ Important Notes
The script must be executed as root or with sudo
Internet access is required
Existing Docker installations may be overwritten
Firewall and SELinux (RHEL) may require additional configuration
🔮 Possible Future Improvements
Docker Swarm auto-init
Portainer installation
Registry mirror configuration
Logging system
CI/CD integration
Offline installation support
Security hardening (sysctl / iptables)
📄 License

MIT License
