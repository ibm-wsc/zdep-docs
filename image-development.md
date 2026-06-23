# Image Development

This section contains comprehensive documentation for developers who create, customize, and publish z/OS demo images for TechZone.

## Overview

The Worldwide Systems Center z/OS Demo Asset Pipeline enables:
- Provision base z/OS instances using Ansible Automation Platform
- Customize z/OS with middleware (CICS, Db2, IMS, MQ) using zconfig-zade
- Create snapshots of customized images
- Publish images to Cloud Object Storage and TechZone

## Workflow

The typical image development workflow consists of:

1. **Provision** - Create a base z/OS instance in the Worldwide Systems Center environment
2. **Customize** - Configure middleware and applications using automation
3. **Test** - Verify the configuration works as expected
4. **Snapshot** - Capture the customized z/OS volumes
5. **Publish** - Upload to Cloud Object Storage and register in TechZone

## Key Technologies

- **Ansible Automation Platform (AAP)** - Orchestrates provisioning and configuration
- **zconfig-zade** - Ansible roles for z/OS middleware configuration
- **IBM Cloud Object Storage** - Stores z/OS image snapshots
- **TechZone** - Demo asset catalog for technical sales

## Getting Started

For those new to image development:
1. Complete the [Onboarding Guide](../getting-started/onboarding) to get access
2. Review [Provisioning Automation](../provisioning/overview) to understand the infrastructure
3. Learn about [Image Customization](../customization/overview) with zconfig-zade
4. Explore existing [Image Configurations](../images/catalog) as examples

## Documentation Sections

Use the navigation menu to explore:
- **Provisioning Automation** - How to provision z/OS instances
- **Image Customization** - How to configure middleware
- **Snapshot & Publishing** - How to capture and publish images
- **Image Configurations** - Detailed docs for each demo image
- **Reference** - Architecture diagrams, environment variables, playbook reference