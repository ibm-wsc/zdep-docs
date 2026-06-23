# Worldwide Systems Center to TechZone z/OS Demo Asset Pipeline

Welcome to the documentation for the **Worldwide Systems Center to TechZone z/OS Demo Asset Pipeline**. This platform enables IBM technical sales teams to provision fully configured, demo-ready z/OS environments directly from TechZone with no additional setup required.

## What Makes This Different?

Unlike standard z/OS environments that require extensive configuration, our demo images are:

- **Fully Pre-Configured**: Middleware (CICS, Db2, IMS, MQ) is installed, configured, and ready to use
- **Demo-Ready**: Sample applications, data, and scenarios are pre-loaded
- **Zero Setup**: Provision and start demonstrating immediately
- **Catalog-Based**: Choose from multiple specialized demo images for different use cases

## Platform Overview

This platform consists of three main components:

1. **Provisioning Automation** - Automated z/OS instance deployment using Ansible Automation Platform
2. **Image Customization** - Tools and processes for creating specialized demo images
3. **Snapshot & Publishing** - Automated pipeline for capturing and publishing images to TechZone

## Quick Links

### For Technical Sales (External Users)
- [Getting Started with Demo Images](./using-images/getting-started) - Start here for provisioning from TechZone
- [Available Demo Images](./images/catalog) - Browse the catalog of available images
- [Demo Scenarios](./using-images/demo-scenarios) - Pre-built demonstration scenarios

<!-- internal-only -->
### For IBM Z Ecosystem Team Members (Internal Users)
- [Onboarding Guide](./getting-started/onboarding) - Get access to the platform
- [Provisioning Automation](./provisioning/overview) - Learn about the provisioning system
- [Image Customization](./customization/overview) - Create and customize demo images
- [Snapshot & Publishing](./snapshot/overview) - Publish images to TechZone
<!-- /internal-only -->

## Architecture

The platform leverages:

- **Worldwide Systems Center Infrastructure**: z/OS instances running on IBM Z hardware in the Worldwide Systems Center
- **Ansible Automation Platform**: Orchestrates provisioning, configuration, and lifecycle management
- **IBM Cloud Object Storage**: Stores z/OS image snapshots
- **TechZone**: Provides self-service provisioning for technical sales teams
- **GitHub Actions**: Automates documentation deployment

## Base z/OS Configuration

All demo images share a common base z/OS configuration that includes:

- z/OS 3.1 or 3.2
- Standard system layout and SMS configuration
- RACF security setup
- Network connectivity via VPN
- SSH access for administration

Each specialized demo image adds specific middleware and demo content on top of this base.

<!-- internal-only -->
## For Platform Administrators

This documentation includes internal-only sections marked with blue banners that contain:

- Detailed architecture and infrastructure information
- Automation playbook documentation
- Maintenance procedures
- Network and storage configuration details

These sections are only visible in the internal build of this documentation.
<!-- /internal-only -->

## Getting Help

- **Technical Sales**: Contact the TechZone support team
- **IBM Z Ecosystem Team Members**: Reach out to Jacob Emery on Slack
- **Issues & Feedback**: Submit via the GitHub repository

## Documentation Structure

This site is organized into the following sections:

- **Getting Started**: Onboarding and access requirements
- **Provisioning Automation**: Using Ansible Automation Platform to deploy instances
- **Image Customization**: Creating and configuring specialized demo images
- **Snapshot & Publishing**: Publishing images to TechZone
- **Demo Image Catalog**: Available images and their configurations
- **Using Demo Images**: Guide for technical sales teams
- **Reference**: Architecture, APIs, and technical details
- **IBM Internal**: Platform administration and maintenance (internal only)