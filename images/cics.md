# CICS Demo Image

The **CICS Demo Image** is a fully configured z/OS environment with CICS Transaction Server 6.2, deployed using IBM's zconfig tool and automated via Ansible.

## Quick Links

- **[Overview](./cics/overview)** - Introduction and key features
- **[What's Included](./cics/whats-included)** - Complete component inventory
- **[Deployment Process](./cics/deployment-process)** - How CICS is configured
- **[Configuration Details](./cics/configuration)** - System and region settings
- **[Customization Guide](./cics/customization)** - Add programs and bundles
- **[Troubleshooting](./cics/troubleshooting)** - Common issues and solutions
- **[Technical Reference](./cics/reference)** - Complete technical reference

## What is CICS?

CICS (Customer Information Control System) Transaction Server is IBM's premier transaction processing system for z/OS, providing high-performance transaction processing, application integration, and RESTful APIs for modern administration.

## This Demo Image Includes

- **z/OS 3.1** with **CICS TS 6.2**
- **Automated deployment** via Ansible and zconfig
- **Sample applications** - COBOL programs and Java bundles
- **CMCI API** - RESTful administration interface
- **SSL/TLS security** - Keyring and certificate configuration

## Getting Started

1. **[Provision](../provisioning/provision-workflow)** - Create a z/OS instance with CICS
2. **[Connect](./cics/whats-included#using-these-components)** - Access via 3270 or CMCI API
3. **[Explore](./cics/whats-included)** - Review included components
4. **[Customize](./cics/customization)** - Add custom programs

## Documentation Structure

### For New Users

Start here to understand the CICS demo image:

1. **[Overview](./cics/overview)** - Understand what's included
2. **[What's Included](./cics/whats-included)** - See all components
3. **[Deployment Process](./cics/deployment-process)** - Learn how it's built

### For Developers

Customize and extend the CICS demo image:

1. **[Customization Guide](./cics/customization)** - Add programs and bundles
2. **[Configuration Details](./cics/configuration)** - Understand settings
3. **[Technical Reference](./cics/reference)** - Complete variable reference

### For Troubleshooting

Resolve issues with the CICS demo image:

1. **[Troubleshooting](./cics/troubleshooting)** - Common problems and solutions
2. **[Configuration Details](./cics/configuration)** - Verify settings
3. **[Technical Reference](./cics/reference)** - Command reference

## Key Features

### Automated Deployment
- Fully automated via Ansible playbooks
- Uses IBM's zconfig tool for region configuration
- Two-phase deployment (z/OS + CMCI)

### Sample Applications
- **HELLO.cbl** - COBOL "Hello World" program
- **HELO** transaction - Demonstrates transaction processing
- Example programs in multiple languages

### Modern Integration
- **CMCI API** - RESTful administration interface
- **Java Bundles** - OSGi bundle deployment
- **Liberty JVM** - Modern Java runtime

## Related Documentation

- **[Customization Overview](../customization/overview)** - How image customization works
- **[Provisioning Workflow](../provisioning/provision-workflow)** - How to provision this image
- **[zconfig-zade Repository](https://github.ibm.com/zeco-iaas/zconfig-zade)** - Ansible automation source

## Getting Help

- **Platform Support**: Contact Jacob Emery on Slack
- **CICS Issues**: Check [Troubleshooting](./cics/troubleshooting) page
- **Automation Issues**: Review AAP job logs