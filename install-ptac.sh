#!/usr/bin/env bash
# Installation script for ptac

set -e

echo "Installing ptac..."

# Check if running as root for system installation
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root for system-wide installation"
  echo "Alternatively, install to ~/bin for user-only installation"
  exit 1
fi

# Download or copy ptac to /usr/local/bin
if [ -f "ptac" ]; then
  cp ptac /usr/local/bin/
else
  echo "Error: ptac script not found in current directory"
  echo "Please download the ptac script first"
  exit 1
fi

chmod +x /usr/local/bin/ptac

# Install manpage
mkdir -p /usr/local/share/man/man1
if [ -f "ptac.1" ]; then
  cp ptac.1 /usr/local/share/man/man1/
  mandb
  echo "Manpage installed successfully"
else
  echo "Warning: ptac.1 manpage not found, skipping manpage installation"
fi

echo "ptac installed successfully!"
echo "Usage: ptac --help"
