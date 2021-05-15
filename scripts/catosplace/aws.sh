#!/bin/bash -eux

echo "==> Installing AWS engineering components"

echo "==> Installing aws-vault"
AWS_VAULT_VERSION="${AWS_VAULT_VERSION:-6.3.1}"
AWS_VAULT_BASE_DOWNLOAD_URL=https://github.com/99designs/aws-vault/releases/download/v"${AWS_VAULT_VERSION}"
AWS_VAULT_DOWNLOAD_URL="${AWS_VAULT_BASE_DOWNLOAD_URL}"/aws-vault-linux-amd64
AWS_VAULT_SHA256SUMS_DOWNLOAD_URL="${AWS_VAULT_BASE_DOWNLOAD_URL}"/SHA256SUMS

# Check file integrity
wget -P ~/Downloads "$AWS_VAULT_DOWNLOAD_URL"
wget -P ~/Downloads "$AWS_VAULT_SHA256SUMS_DOWNLOAD_URL"
cd ~/Downloads
sha256sum -c SHA256SUMS 2>&1 | grep OK

# Install aws-vault with shell completion
sudo mv aws-vault-linux-amd64 /usr/local/bin/aws-vault
chmod +x /usr/local/bin/aws-vault
aws-vault --version
aws-vault --completion-script-bash | sudo tee /etc/bash_completion.d/aws-vault
rm SHA256SUMS