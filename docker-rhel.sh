#!/bin/bash

set -e

# ==============================
# HEADER
# ==============================
echo "========================================="
echo "   Docker Installer - RHEL Based"
echo "   By gustavoohrodrigues"
echo "========================================="
echo ""

# ==============================
# CHECK ROOT
# ==============================
if [ "$EUID" -ne 0 ]; then
    echo "[ERROR] Execute como root ou use sudo"
    exit 1
fi

# ==============================
# CHECK DNF
# ==============================
if ! command -v dnf >/dev/null 2>&1; then
    echo "[ERROR] Este script requer dnf (RHEL 8+ / Fedora / Rocky / AlmaLinux)"
    exit 1
fi

# ==============================
# DETECT DISTRO
# ==============================
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO_ID="${ID,,}"
else
    echo "[ERROR] Não foi possível detectar a distribuição"
    exit 1
fi

echo "[INFO] Distribuição detectada: $NAME"

# Define URL do repositório conforme a distro
case "$DISTRO_ID" in
    fedora)
        DOCKER_REPO_URL="https://download.docker.com/linux/fedora/docker-ce.repo"
        ;;
    rhel|centos|rocky|almalinux)
        DOCKER_REPO_URL="https://download.docker.com/linux/centos/docker-ce.repo"
        ;;
    *)
        echo "[WARN] Distro '$DISTRO_ID' não reconhecida. Usando repo do CentOS como fallback..."
        DOCKER_REPO_URL="https://download.docker.com/linux/centos/docker-ce.repo"
        ;;
esac

# ==============================
# MENU
# ==============================
echo "Deseja continuar com a instalação do Docker?"
echo "1) Prosseguir"
echo "2) Sair"
echo ""

read -p "Escolha uma opção [1-2]: " OPCAO

case $OPCAO in
    1)
        echo "[INFO] Iniciando instalação..."
        ;;
    2)
        echo "[INFO] Saindo..."
        exit 0
        ;;
    *)
        echo "[ERROR] Opção inválida"
        exit 1
        ;;
esac

# ==============================
# REMOVE OLD DOCKER
# ==============================
echo "[INFO] Removendo versões antigas e pacotes conflitantes..."
dnf remove -y \
    docker docker-client docker-client-latest docker-common \
    docker-latest docker-latest-logrotate docker-logrotate \
    docker-engine moby-engine podman-docker 2>/dev/null || true

# ==============================
# INSTALL DEPENDENCIES
# ==============================
echo "[INFO] Instalando dependências..."
dnf install -y curl

# ==============================
# ADD REPOSITORY
# ==============================
# Usa curl em vez de dnf config-manager --add-repo,
# compatível com DNF4 e DNF5 (Fedora 41+)
echo "[INFO] Adicionando repositório Docker..."
curl -fsSL "$DOCKER_REPO_URL" -o /etc/yum.repos.d/docker-ce.repo
echo "[OK] Repositório adicionado: /etc/yum.repos.d/docker-ce.repo"

# ==============================
# INSTALL DOCKER
# ==============================
echo "[INFO] Instalando Docker..."
# --allowerasing necessário no Fedora para resolver conflitos com moby-engine
dnf install -y --allowerasing \
    docker-ce docker-ce-cli containerd.io \
    docker-buildx-plugin docker-compose-plugin

# ==============================
# ENABLE SERVICE
# ==============================
echo "[INFO] Habilitando Docker..."
systemctl enable docker
systemctl start docker

# ==============================
# VALIDATION
# ==============================
echo "[INFO] Validando instalação..."
if docker system info >/dev/null 2>&1; then
    echo "[OK] Docker está funcionando 🚀"
else
    echo "[ERROR] Falha ao validar Docker"
    exit 1
fi

# ==============================
# OPTIONAL USER
# ==============================
if [ -n "$SUDO_USER" ]; then
    echo "[INFO] Adicionando usuário '$SUDO_USER' ao grupo docker..."
    usermod -aG docker "$SUDO_USER"
    echo "[WARN] Faça logout/login para aplicar permissões de grupo"
fi

# ==============================
# FINAL
# ==============================
echo ""
echo "[OK] Docker instalado com sucesso"
echo ""
echo "========================================="
echo "   By: gustavoohrodrigues"
echo "========================================="
