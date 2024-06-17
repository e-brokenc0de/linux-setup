# Linux Setup Script

This repository contains a setup script for configuring a new Ubuntu system with commonly used tools and software.

## Features

- Install and configure PHP with selected extensions
- Install PHP Composer
- Configure Zsh with Antigen bundles and a selected theme
- Optionally install Bun
- Optionally install Docker

## Prerequisites

- An Ubuntu system with internet access
- `curl`, `gnupg`, `sudo`, `lsb-release`, and `ca-certificates` installed (the script will install these if they are not already present)

## Installation

You can run the setup script using the following one-liner:

```sh
bash <(curl -s https://raw.githubusercontent.com/e-brokenc0de/linux-setup/main/ubuntu.sh)
```
