# Packer Usage

This directory contains a sample Packer build instruction file called vio.json. It utilized variables to avoid hard coding the user password to it.

Usage is as follows:
packer validate -var os_password=WhatIsSecurity? web-server-image.json
packer build -var 'os_password=WhatIsSecurity?' web-server-image.json