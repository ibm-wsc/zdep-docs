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
### For Image Developers
Platform access and image development:
- [Onboarding Guide](./getting-started/onboarding) - Get platform access
- [Provisioning Workflow](./provisioning/provision-workflow) - Deploy test instances
- [Image Customization](./customization/overview) - Build new demo images
- [Publishing Process](./snapshot/overview) - Release images to TechZone
<!-- /internal-only -->

## Platform Architecture

The platform consists of three main layers:

### 1. z/OS Standard Image
The base layer shared by all customized z/OS images in this catalog.
- Shared by multiple IBM programs, built by the IBM Z Ecosystem Infrastructure team using infrastructure-as-code best practices and modern tooling.
- Detailed z/OS system layout information can be found [here](https://zlpn-docs.zlpn.wdc.app.cirrus.ibm.com/docs/hdisv/image-configuration/system-layout/)
- Standardized z/OS image for demos to be built on.
- RACF security configuration and SMS setup
- Network connectivity via VPN
- SSH access for administration

### 2. WSC Customization Pipeline
Automation in the Worldwide Systems Center extends the Standard Imag with specialized configurations:
- **Ansible Automation Platform**: Orchestrates provisioning and configuration using Ansible.
- **zconfig Automation**: Applies middleware-specific customizations (CICS, Db2, IMS, MQ) in combination with Ansible. Sign up for public beta access to zconfig [here](https://ibm.biz/zconfig-beta).
- **Snapshot Tools**: Captures and publishes configured images to Cloud Object Storage
- **IBM Cloud Object Storage**: Stores image snapshots for eventual use by TechZone for provisioning

### 3. TechZone Self-Service
The final delivery mechanism for technical sales and business partners:
- A catalog of demo-ready images available for immediate provisioning on TechZone [here](https://techzone.ibm.com/collection/zos-custom/environments).
- No additional setup or configuration required
- Secure VPN access to z/OS environments
- Self-service lifecycle management

## Getting Help

- **Technical Sales & Business Partners**: Contact the TechZone support
- **Image Developers**: Reach out to Jacob Emery on Slack and join the [#wsc-demo-hosting-in-techzone-workstreams](https://ibm.enterprise.slack.com/archives/C08K4MKMMKK) Slack channel
- **Issues & Feedback**
    - Issues and requests for the z/OS Standard Image should be added [here](https://github.ibm.com/IBM-Z-Ecosystem/hrh-configuration/issues).
    - To request a new image to be made available, submit a WSC Request Form [here](https://wkf.ms/3R2k1pA).

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

- **Image Development**: Aimed at creators of the z/OS images in this catalog, and the administrators of that platform.
- **Demo Delivery**: Aimed at IBM Technical Sales and Business Partners for them to reference when demonstrating z/OS using the images in this catalog on TechZone. 