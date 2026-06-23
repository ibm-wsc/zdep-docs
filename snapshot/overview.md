# Snapshot & Publishing Overview

This section covers the process of capturing customized z/OS images and publishing them to TechZone for use by IBM technical sales teams. The snapshot and publishing pipeline automates the entire process from capturing a running z/OS instance to making it available in the TechZone catalog.

## What is Snapshotting?

**Snapshotting** is the process of capturing the current state of a z/OS instance, including:

- All z/OS volumes (system and user)
- Middleware configurations
- Installed applications
- User data and customizations
- System settings and security profiles

The snapshot is compressed, packaged, and stored in IBM Cloud Object Storage (COS), where it can be:
- Downloaded for local testing
- Published to TechZone for provisioning
- Versioned and tracked over time

---

## Publishing Pipeline Architecture

```mermaid
graph LR
    A[Running z/OS Instance] --> B[Create Snapshot]
    B --> C[Compress Volumes]
    C --> D[Upload to COS]
    D --> E[Publish to TechZone]
    E --> F[Available for Provisioning]
```

### Components

1. **mirror-zade-images Repository**: Ansible playbooks for snapshot and publishing
2. **IBM Cloud Object Storage (COS)**: Stores compressed z/OS images
3. **Local Web Server**: Intermediate storage for image processing
4. **TechZone**: Self-service provisioning platform for technical sales

---

## The Snapshot Process

### Phase 1: Preparation

Before creating a snapshot:

1. **Stop z/OS**: Ensure z/OS is cleanly shut down
2. **Verify Configuration**: Confirm all customizations are complete
3. **Test Thoroughly**: Validate all middleware and applications work
4. **Document Changes**: Record what's included in this snapshot

### Phase 2: Volume Capture

The snapshot process:

1. **Attach Snapshot Volume**: Creates temporary storage in OpenStack
2. **Mount Volume**: Makes it accessible on the zADE server
3. **Remount Read-Only**: Protects source volumes during capture
4. **Compress Volumes**: Uses parallel compression for speed
5. **Create Tarball**: Packages all compressed volumes
6. **Restore Read-Write**: Returns volumes to normal operation

### Phase 3: Publishing

After capture:

1. **Upload to COS**: Stores snapshot in IBM Cloud Object Storage
2. **Copy to Web Server**: Makes available for local provisioning (optional)
3. **Update Symlinks**: Points "latest" to new version
4. **Publish to TechZone**: Makes available for technical sales

---

## Snapshot Workflow Automation

The snapshot process is fully automated using Ansible Automation Platform workflows. The main workflows are:

### 1. Create Snapshot Workflow

**Purpose**: Capture a running z/OS instance

**Steps**:
1. Verify z/OS is stopped
2. Create and attach snapshot volume
3. Compress all z/OS volumes
4. Create tarball with manifest and devmap
5. Upload to Cloud Object Storage

**Duration**: ~30-45 minutes depending on image size

### 2. Publish to Web Server Workflow

**Purpose**: Make snapshot available on local web server

**Steps**:
1. Download from COS to web server
2. Extract tarball
3. Generate file list
4. Set permissions for Apache

**Duration**: ~15-20 minutes

### 3. Update Latest Symlink Workflow

**Purpose**: Point "latest" symlink to new version

**Steps**:
1. Validate new release exists
2. Remove old symlink
3. Create new symlink to latest version
4. Verify symlink creation

**Duration**: Less than 1 minute

---

## Naming Conventions

### Snapshot Names

Format: `zos-{version}-{type}-{date}`

Examples:
- `zos-v3r1-lte1-2024-01` - z/OS 3.1 LTE, January 2024
- `zos-v3r2-cics-2024-06` - z/OS 3.2 with CICS, June 2024

### Version Symlinks

Each z/OS version has a "latest" symlink:
- `zos-v3r1-lte1-latest` → points to most recent v3.1 snapshot
- `zos-v3r2-lte1-latest` → points to most recent v3.2 snapshot

This allows provisioning workflows to always use the latest version without hardcoding snapshot names.

---

## Storage Locations

### IBM Cloud Object Storage (COS)

**Purpose**: Primary storage for z/OS snapshots

**Structure**:
```
Bucket: zos-v3r1-lte1-2024-01/
├── zos-v3r1-lte1-2024-01.tar    # Compressed volumes
├── manifest.yaml                 # Image metadata
└── devmap                        # Device mapping
```

**Benefits**:
- Durable, redundant storage
- Accessible from anywhere
- Version controlled
- Cost-effective

### Local Web Server

**Purpose**: Fast local access for WSC provisioning

**Location**: `/var/www/html/`

**Structure**:
```
/var/www/html/
├── zos-v3r1-lte1-2024-01/
│   ├── *.ckd.gz                  # Individual compressed volumes
│   ├── manifest.yaml
│   ├── devmap
│   └── filelist.txt
└── zos-v3r1-lte1-latest/         # Symlink to latest
```

**Benefits**:
- Faster downloads within WSC network
- Reduced COS egress costs
- Local testing and validation

---

## Snapshot Contents

### What's Included

✅ **System Volumes**:
- z/OS system datasets
- System configuration (PARMLIB, PROCLIB)
- System software (compilers, utilities)

✅ **User Volumes**:
- Middleware configurations
- Application code and data
- User datasets and files
- Custom scripts and tools

✅ **Metadata**:
- `manifest.yaml` - Image description and requirements
- `devmap` - Device mapping configuration
- Volume inventory

### What's NOT Included

❌ **Temporary Data**:
- Temporary datasets
- Spool files
- Log files (unless specifically preserved)

❌ **Sensitive Information**:
- Passwords (must be reset on first use)
- Private keys
- Customer data

❌ **Instance-Specific Config**:
- IP addresses (assigned at provision time)
- Hostnames
- Network configuration

---

## Publishing to TechZone

### Prerequisites

Before publishing to TechZone:

1. ✅ Snapshot created and uploaded to COS
2. ✅ Image thoroughly tested
3. ✅ Documentation prepared
4. ✅ Demo scenarios validated
5. ✅ TechZone catalog entry created

### TechZone Integration

The integration process:

1. **Create TechZone Asset**: Define the demo image in TechZone catalog
2. **Configure Provisioning**: Set up automation to pull from COS
3. **Set Access Controls**: Define who can provision the image
4. **Add Documentation**: Link to usage guides and demo scenarios
5. **Test Provisioning**: Validate end-to-end provisioning works

### TechZone Asset Types

**Collection**: Group of related demo images
- Example: "z/OS Middleware Demos"

**Environment**: Individual demo image
- Example: "z/OS 3.1 with CICS 6.2"

**Journey**: Guided demo scenario
- Example: "CICS Transaction Processing Demo"

---

## Version Management

### Versioning Strategy

We use date-based versioning for snapshots:

- **Major Version**: z/OS version (v3r1, v3r2)
- **Type**: Image type (lte1, cics, db2, etc.)
- **Date**: YYYY-MM format

Example progression:
```
zos-v3r1-lte1-2024-01  (January release)
zos-v3r1-lte1-2024-04  (April update)
zos-v3r1-lte1-2024-07  (July update)
```

### Latest Symlinks

The "latest" symlink always points to the most recent stable version:

```bash
zos-v3r1-lte1-latest → zos-v3r1-lte1-2024-07
```

This allows:
- Provisioning workflows to use "latest" without updates
- Easy rollback by changing symlink
- Clear version history

### Rollback Procedure

If a new snapshot has issues:

1. Identify the previous stable version
2. Update the "latest" symlink to point to it
3. Notify users of the rollback
4. Fix issues in the new version
5. Re-publish when ready

---

## Snapshot Best Practices

### 1. Clean Shutdown

Always cleanly shut down z/OS before snapshotting:
```bash
# Use the "Stop z/OS" workflow in AAP
# Or manually: /S SHUTDOWN
```

### 2. Verify Completeness

Before snapshotting, verify:
- All middleware is configured
- All applications are deployed
- All tests pass
- Documentation is updated

### 3. Test the Snapshot

After creating a snapshot:
1. Provision a new instance from it
2. Verify all middleware starts
3. Test all demo scenarios
4. Confirm documentation is accurate

### 4. Document Changes

For each snapshot, document:
- What changed from previous version
- New features or middleware
- Known issues or limitations
- Demo scenarios included

### 5. Maintain Multiple Versions

Keep at least 2-3 recent versions:
- Current "latest"
- Previous stable version (for rollback)
- Older version (for compatibility)

---

## Monitoring and Maintenance

### Snapshot Metrics

Track these metrics:

- **Snapshot Size**: Monitor growth over time
- **Compression Ratio**: Optimize storage costs
- **Creation Time**: Identify performance issues
- **Success Rate**: Track failures and errors

### Regular Maintenance

**Monthly**:
- Review and clean up old snapshots
- Update "latest" symlinks
- Test provisioning from TechZone
- Update documentation

**Quarterly**:
- Audit snapshot inventory
- Review storage costs
- Update base z/OS images
- Refresh middleware versions

---

## Troubleshooting

### Common Issues

**Snapshot creation fails**
- Check disk space on snapshot volume
- Verify z/OS is fully stopped
- Review compression logs
- Check OpenStack volume status

**Upload to COS fails**
- Verify COS credentials
- Check network connectivity
- Confirm bucket exists
- Review COS quota limits

**Provisioning from snapshot fails**
- Verify manifest.yaml is correct
- Check devmap configuration
- Confirm all volumes are present
- Review provisioning logs

**TechZone provisioning issues**
- Verify TechZone asset configuration
- Check COS bucket permissions
- Confirm network connectivity
- Review TechZone logs

---

## Security Considerations

### Data Protection

- **Encryption**: All snapshots are encrypted in COS
- **Access Control**: Bucket access restricted to authorized users
- **Audit Logging**: All access is logged and monitored

### Sensitive Data

Before snapshotting:
- Remove any customer data
- Clear temporary files
- Reset default passwords
- Remove private keys

### Compliance

Ensure snapshots comply with:
- IBM data handling policies
- Export control regulations
- Customer data protection requirements

---

## Next Steps

Ready to create the first snapshot? Follow these guides:

1. **[Creating Snapshots](./creating-snapshots)** - Step-by-step snapshot process
2. **[Publishing to COS](./publishing-cos)** - Upload to Cloud Object Storage
3. **[Publishing to TechZone](./publishing-techzone)** - Make available for provisioning
4. **[Workflow Automation](./workflow-automation)** - Using AAP workflows

---

## Getting Help

- **Snapshot Issues**: Check the mirror-zade-images repository README
- **COS Issues**: Contact IBM Cloud support
- **TechZone Issues**: Contact TechZone support team
- **Platform Support**: Contact Jacob Emery on Slack