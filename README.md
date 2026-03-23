# 🐳 Docker Installation Script

A Bash-based automation tool designed to simplify Docker installation on Linux systems.

This project provides **automated, production-ready scripts** to install Docker on:

- Debian-based distributions (Ubuntu, Debian)
- RHEL-based distributions (CentOS, Rocky, AlmaLinux)

The goal is to provide a **fast, reliable, and repeatable installation process** for SysAdmins, DevOps engineers, and NOC/SOC teams.

---

## 👤 Author

**Gustavo Henrique Rodrigues**  
SysAdmin – Engineer  

🔗 LinkedIn  
https://www.linkedin.com/in/gustavo-henrique-rodrigues-3070a5260  

---

## Features

- Automated Docker installation
- Support for Debian-like and RHEL-like systems
- Official Docker repository configuration
- GPG key management
- Service auto-start and enable
- Validation after installation
- Interactive execution (menu: install or exit)
- Clean and reproducible setup
- Production-ready scripts
- No interactive prompts during package install
- Compatible with automation (CI/CD, Ansible, etc.)

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

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/gustavoohrodrigues/docker-install.git
cd docker-install
```

---

### 2. Make scripts executable

```bash
chmod +x docker-install.sh docker-rhel.sh
```

---

### 3. Run the script

#### Debian / Ubuntu

```bash
sudo ./docker-install.sh
```

#### RHEL / CentOS / Rocky / AlmaLinux

```bash
sudo ./docker-rhel.sh
```

---

## Menu (Interactive Mode)

```
=========================================
   Docker Installer
   By gustavoohrodrigues
=========================================

Deseja continuar com a instalação do Docker?

1) Prosseguir
2) Sair
```

---

## What the script does

### Debian-based

- Updates system packages
- Installs required dependencies
- Downloads and configures Docker GPG key
- Configures official Docker repository
- Installs:
  - docker-ce
  - docker-ce-cli
  - containerd.io
  - docker-buildx-plugin
  - docker-compose-plugin
- Enables and starts Docker service
- Validates installation with `docker system info`

---

### RHEL-based

- Removes old Docker versions
- Installs required dependencies
- Adds official Docker repository
- Installs Docker Engine and related tools
- Enables and starts Docker service
- Validates installation

---

## 📂 Project Structure

```
docker-install/
├── docker-install.sh         # Debian/Ubuntu script
├── docker-install-rhel.sh    # RHEL-based script
└── README.md
```

---

## Validation

After installation, the script runs:

```bash
docker system info
```

If successful, Docker is properly installed and running.

---

## Post-install (Optional)

To run Docker without sudo:

```bash
sudo usermod -aG docker $USER
```

Then apply permissions:

```bash
newgrp docker
```

---

## Important Notes

- Must be executed as root or with sudo
- Requires internet access
- Existing Docker installations may be overwritten
- Firewall rules may need adjustment
- SELinux (RHEL-based systems) may require configuration

---

## 💡 Example Output

```
[INFO] Atualizando pacotes...
[INFO] Instalando dependências...
[INFO] Configurando repositório...
[INFO] Instalando Docker...
[INFO] Validando instalação...

[OK] Docker instalado com sucesso 
```

---

## Possible Future Improvements

- Docker Swarm auto-init
- Portainer installation
- Private registry configuration
- Logging system
- Monitoring integration (Zabbix, Prometheus)
- Offline installation support
- Security hardening (sysctl, iptables)
- Multi-node cluster bootstrap

---

## License

MIT License
