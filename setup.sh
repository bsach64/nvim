#!/bin/bash
set -euxo pipefail

echo "update"
sudo apt update -y && sudo apt upgrade -y
sudo apt install git curl make build-essential fontconfig unzip -y

mkdir -p $HOME/.config/
mkdir -p $HOME/Code/

echo "zsh"
sudo apt install zsh zsh-autosuggestions -y
sudo chsh -s "$(which zsh)" "$(whoami)"
ln -sf $HOME/Code/setup/.zshrc $HOME/.zshrc

# install neovim
echo "neovim"
sudo snap install nvim --classic
ln -sfn $HOME/Code/setup/nvim $HOME/.config

echo "rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"
rustup component add rust-analyzer

echo "tmux"
sudo apt install -y tmux fd-find
cargo install skim
ln -sf $HOME/Code/setup/.tmux.conf $HOME/.tmux.conf

echo "golang"
sudo snap install go --classic
export PATH="$PATH:/snap/bin"
go install golang.org/x/tools/gopls@latest

echo "criu"
sudo apt install -y \
	asciidoctor \
	bash \
	bsdmainutils \
	build-essential \
	gdb \
	git-core \
	iptables \
	kmod \
	libaio-dev \
	libbsd-dev \
	libcap-dev \
	libdrm-dev \
	libelf-dev \
	libgnutls28-dev \
	libgnutls30 \
	libnet-dev \
	libnl-3-dev \
	libnl-route-3-dev \
	libperl-dev \
	libprotobuf-c-dev \
	libprotobuf-dev \
	libselinux-dev \
	libtraceevent-dev \
	libtracefs-dev \
	pkg-config \
	protobuf-c-compiler \
	protobuf-compiler \
	python3-importlib-metadata \
	python3-pip \
	python3-protobuf \
	python3-yaml \
	time \
	util-linux \
	uuid-dev

git clone https://github.com/checkpoint-restore/criu.git $HOME/Code/criu-main

echo "node js"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 24

echo "lsp setup"
sudo apt install clangd bear -y
npm install -g pyright
cargo install --locked tree-sitter-cli

echo "uv"
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "opencode"
curl -fsSL https://opencode.ai/install | bash

echo "tv"
curl -fsSL https://alexpasmantier.github.io/television/install.sh | bash

echo "vicinae"
curl -fsSL https://vicinae.com/install.sh | bash

echo "ghostty"
sudo snap install ghostty --classic
ln -sfn $HOME/Code/setup/ghostty $HOME/.config/

echo "Iosevka"
mkdir -p /tmp/font-install/
curl -sL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/IosevkaTerm.zip" -o "/tmp/font-install/IosevkaTerm.zip"
mkdir -p /tmp/font-install/extracted/
unzip -q "/tmp/font-install/IosevkaTerm.zip" -d "/tmp/font-install/extracted"
mkdir -p $HOME/.local/share/fonts/
find "/tmp/font-install/extracted" -name "*.ttf" -exec cp {} "$HOME/.local/share/fonts/" \;
fc-cache -fv "$HOME/.local/share/fonts/" > /dev/null 2>&1
rm -rf /tmp/font-install/

# install gh and login
echo "github"

(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

gh auth login
