#!/bin/sh
FOLDER=$HOME/.local/bin

mkdir -p "$FOLDER"

sudo chown -R "$USER:$USER" "$FOLDER"
sudo chmod -R 755 "$FOLDER"

python3 -m pip install --user --upgrade pip setuptools keyrings.alt --break-system-packages
python3 -m pip install --user testresources wheel --break-system-packages
python3 -m pip install --user -r scripts/requirements.txt --break-system-packages
