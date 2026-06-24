# IBM Z Demo Enablement Program (ZDEP)

Welcome to the documentation for the **Worldwide Systems Center's IBM Z Demo Enablement Program (ZDEP)**. This platform enables IBM and Business Partner technical sales teams to provision fully configured, demo-ready z/OS environments from TechZone with no additional setup required.

## Why?

IBM technical sales and Business Partners need reliable, scalable access to fully configured z/OS environments for client demonstrations. Even when the primary product isn't z/OS-based, many IBM solutions build on the foundation z/OS provides. This program delivers demo-ready z/OS images that can be provisioned on-demand with zero setup.

## Quick Links

### For Technical Sales & Business Partners
Start here to provision and use demo images from TechZone:
- [Demo Catalog](https://techzone.ibm.com/collection/zos-custom/environments) - Browse available images for self-service provisioning on TechZone.
- [Demo Documentation](./using-images/getting-started) - Reference for how to use the different images in the catalog to demonstrate z/OS and related products.

<!-- internal-only -->
### For IBM Z Ecosystem Team Members
Platform access and image development:
- [Onboarding Guide](./getting-started/onboarding) - Get platform access
- [Provisioning Workflow](./provisioning/provision-workflow) - Deploy test instances
- [Image Customization](./customization/overview) - Build new demo images
- [Publishing Process](./snapshot/overview) - Release images to TechZone
<!-- /internal-only -->

## Platform Architecture

The platform consists of three main layers:

### 1. z/OS Standard Image Foundation
The base layer shared by all specialized demo images:
- z/OS 3.1 or 3.2 with standard system layout
- RACF security configuration and SMS setup
- Network connectivity via VPN
- SSH access for administration
- Built with infrastructure-as-code best practices

### 2. WSC Customization Pipeline
WSC automation extends the base image with specialized configurations:
- **Ansible Automation Platform**: Orchestrates provisioning and configuration
- **zconfig Automation**: Applies middleware-specific customizations (CICS, Db2, IMS, MQ)
- **IBM Cloud Object Storage**: Stores image snapshots
- **Snapshot Tools**: Captures and publishes configured images

### 3. TechZone Self-Service
The final delivery mechanism for technical sales:
- Demo-ready images available for immediate provisioning
- No additional setup or configuration required
- Secure VPN access to z/OS environments
- Self-service lifecycle management

## Getting Help

- **Technical Sales & Business Partners**: Contact the TechZone support team
- **IBM Z Ecosystem Team Members**: Reach out to Jacob Emery on Slack
- **Issues & Feedback**: Submit via the GitHub repository

<!-- internal-only -->
## For Platform Administrators

This documentation includes internal-only sections marked with blue banners that contain:

- Detailed architecture and infrastructure information
- Automation playbook documentation and maintenance procedures
- Network and storage configuration details
- Image development and publishing workflows

These sections are only visible in the internal build of this documentation.
<!-- /internal-only -->

## Documentation Guide

This site is organized to serve two primary audiences:

- **Using Demo Images** (Public): For technical sales provisioning from TechZone
- **Getting Started** (Internal): Platform onboarding and access requirements
- **Provisioning** (Internal): Deploy and manage test instances in WSC
- **Customization** (Internal): Configure middleware and create new images
- **Snapshot & Publishing** (Internal): Release images to TechZone
- **Demo Image Catalog**: Detailed configuration for each available image
- **Reference**: Technical specifications, FAQs, and troubleshooting