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
echo "[ERROR] Este script requer dnf (RHEL 8+ / Rocky / AlmaLinux)"
exit 1
fi

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

echo "[INFO] Removendo versões antigas..."
dnf remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine || true

# ==============================

# INSTALL DEPENDENCIES

# ==============================

echo "[INFO] Instalando dependências..."
dnf install -y dnf-plugins-core

# ==============================

# ADD REPOSITORY

# ==============================

echo "[INFO] Adicionando repositório Docker..."
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# ==============================

# INSTALL DOCKER

# ==============================

echo "[INFO] Instalando Docker..."
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

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
echo "[INFO] Adicionando usuário ao grupo docker..."
usermod -aG docker "$SUDO_USER"
echo "[WARN] Faça logout/login para aplicar permissões"
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
