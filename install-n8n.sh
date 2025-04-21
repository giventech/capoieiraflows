#!/bin/bash
set -e

echo "📦 Updating packages..."
sudo apt update && sudo apt upgrade -y

echo "🧰 Installing Node.js and npm..."
sudo apt install -y nodejs npm

echo "🔄 Fixing possible npm permission issues..."
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH="$HOME/.npm-global/bin:$PATH"
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.bashrc

echo "🚀 Installing n8n globally..."
npm install n8n -g

echo " Setting up basic authentication for security..."
read -p "Enter n8n username: " N8N_USER
read -p "Enter n8n password: " N8N_PASSWORD
echo ""

export N8N_BASIC_AUTH_ACTIVE=true
export N8N_BASIC_AUTH_USER=$N8N_USER
export N8N_BASIC_AUTH_PASSWORD=$N8N_PASSWORD

echo " Starting n8n server..."
n8n start --host 0.0.0.0

