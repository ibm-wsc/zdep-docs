# CICS Demo Image - Overview

The **CICS Demo Image** is a fully configured z/OS environment with CICS Transaction Server 6.2, deployed using IBM's zconfig tool and automated via Ansible. This image showcases CICS capabilities, transaction processing, and modern application integration.

## What is CICS?

CICS (Customer Information Control System) Transaction Server is IBM's premier transaction processing system for z/OS. It provides:

- **High-performance transaction processing** - Millions of transactions per second
- **Application integration** - Connect COBOL, Java, and modern applications
- **RESTful APIs** - Modern CMCI interface for administration
- **Enterprise scalability** - Proven reliability for mission-critical workloads

## This Demo Image Includes

- **z/OS 3.1** - Latest z/OS operating system
- **CICS TS 6.2** - CICS Transaction Server for z/OS
- **Zconfig-based Deployment** - Automated region configuration
- **Sample Applications** - COBOL programs with CMCI deployment
- **Java Bundles** - OSGi bundles for modern integration
- **VSAM Files** - Pre-configured data files
- **SSL/TLS Security** - Keyring and certificate configuration

## Key Features

### Automated Deployment
- Fully automated via Ansible playbooks
- Uses IBM's zconfig tool for region configuration
- Two-phase deployment (z/OS + CMCI)
- Repeatable and consistent

### Sample Applications
- **HELLO.cbl** - Simple COBOL "Hello World" transaction
- **HELO** transaction - Demonstrates transaction processing
- Example programs in multiple languages (COBOL, PL/I, C, C++, Assembler, REXX)

### Modern Integration
- **CMCI API** - RESTful interface for administration
- **Java Bundles** - OSGi bundle deployment
- **Liberty JVM** - Modern Java runtime
- **VSAM Access** - Traditional and modern data access patterns

### Security
- RACF integration
- SSL/TLS certificates
- Keyring configuration
- Liberty Angel process

## Use Cases

This demo image is ideal for:

- **Technical enablement** - Training technical sales on CICS capabilities
- **Customer demonstrations** - Showing CICS features and integration
- **Proof of concepts** - Testing CICS applications and configurations
- **Development and testing** - Building and testing CICS applications

## Quick Start

1. **Provision** - Use AAP to provision a z/OS instance with CICS
2. **Connect** - Access via 3270 terminal or CMCI API
3. **Run** - Execute the HELO transaction
4. **Explore** - View programs, bundles, and files

## Documentation Structure

- **[What's Included](./whats-included)** - Detailed inventory of components
- **[Deployment Process](./deployment-process)** - How CICS is configured
- **[Configuration Details](./configuration)** - System, security, and region settings
- **[Customization Guide](./customization)** - How to add programs and bundles
- **[Troubleshooting](./troubleshooting)** - Common issues and solutions
- **[Technical Reference](./reference)** - Ansible roles, variables, and formats

## Getting Help

- **CICS Issues**: Check region logs in `/var/cicsts/regions/<APPLID>/logs/`
- **Zconfig Issues**: Run `zconfig ls` and `zconfig logs <APPLID>`
- **CMCI Issues**: Verify CMCI port and credentials
- **Automation Issues**: Check AAP job logs
- **Platform Support**: Contact Jacob Emery on Slack

## Related Documentation

- **[Customization Overview](../../customization/overview)** - How image customization works
- **[Provisioning Workflow](../../provisioning/provision-workflow)** - How to provision this image
- **[zconfig-zade Repository](https://github.ibm.com/zeco-iaas/zconfig-zade)** - Ansible automation source
- **[CICS Role README](https://github.ibm.com/zeco-iaas/zconfig-zade/blob/main/roles/cics_config/README.md)** - Detailed role documentation