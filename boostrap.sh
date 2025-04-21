#!/bin/bash

set -e

echo " Updating and installing essential tools..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y python3 python3-pip build-essential curl git

# Install ffmpeg separately
echo "installing ffmpeg..."
sudo apt install -y ffmpeg

echo " Ensuring pip3 is up to date..."
python3 -m pip install --upgrade pip

echo " Installing PyTorch (CPU only)..."
# Make sure we're using the correct PyTorch index URL
python3 -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu

echo "Installing Python libraries..."
# Install the rest of the libraries
python3 -m pip install --no-cache-dir \
	    chromadb \
	        sentence-transformers \
		    streamlit

# Install faster-whisper (fall back to GitHub if pip install fails)
echo " Installing faster-whisper..."
if ! python3 -m pip install faster-whisper; then
	    echo " PyPI install failed. Installing faster-whisper from GitHub..."
	        python3 -m pip install git+https://github.com/guillaumekln/faster-whisper.git
fi

echo " All tools and Python packages installed (CPU only)"
