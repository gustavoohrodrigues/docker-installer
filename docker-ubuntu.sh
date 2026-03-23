#!/bin/bash

set -e

# ==============================

# HEADER

# ==============================

echo "========================================="
echo "   Docker Installer - Ubuntu"
echo "   By gustavoohrodrigues"
echo "========================================="
echo ""

# ==============================

# CHECK ROOT

# ==============================

if [ "$EUID" -ne 0 ]; then
echo "[ERRO] Execute como root ou use sudo"
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
echo "[ERRO] Opção inválida"
exit 1
;;
esac

# ==============================

# INSTALL

# ==============================

echo "[INFO] Atualizando pacotes..."
apt-get update -y

echo "[INFO] Instalando dependências..."
apt-get install -y ca-certificates curl gnupg lsb-release

echo "[INFO] Criando diretório de keyrings..."
mkdir -p /etc/apt/keyrings

echo "[INFO] Baixando chave GPG..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /tmp/docker.gpg

gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg /tmp/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
rm -f /tmp/docker.gpg

echo "[INFO] Detectando versão do Ubuntu..."
CODENAME=$(lsb_release -cs)

echo "[INFO] Configurando repositório..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $CODENAME stable" > /etc/apt/sources.list.d/docker.list

echo "[INFO] Atualizando repositórios..."
apt-get update -y

echo "[INFO] Instalando Docker..."
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[INFO] Habilitando serviço..."
systemctl enable docker
systemctl start docker

echo "[INFO] Validando instalação..."
docker system info > /dev/null

# ==============================

# FINAL

# ==============================

echo ""
echo "[OK] Docker instalado com sucesso"
echo ""
echo "========================================="
echo "   By: gustavoohrodrigues"
echo "========================================="
