# CICS Customization Guide

This page explains how to customize the CICS demo image by adding programs, transactions, bundles, and files.

## Overview

The CICS demo image can be customized by modifying the `zconfig-zade` repository and redeploying. All customizations are defined in:

- **Programs**: `roles/cics_config/files/programs/`
- **Bundles**: `roles/cics_config/files/bundles/`
- **Resources**: `roles/cics_config/files/cics_resources.yml`
- **Zconfig**: `roles/cics_config/files/zconfig/`

## Adding New Programs

### Step 1: Add Source File

Add the program source file to `roles/cics_config/files/programs/`:

```bash
# Example: Add a new COBOL program
cp MYPROG.cbl roles/cics_config/files/programs/
```

### Step 2: Update cics_resources.yml

Edit `roles/cics_config/files/cics_resources.yml`:

```yaml
cics_resources:
  programs:
    - name: HELLO
      language: cobol
      source_file: programs/HELLO.cbl
    
    # Add the new program
    - name: MYPROG
      language: cobol
      source_file: programs/MYPROG.cbl
```

### Step 3: Add Transaction (Optional)

To add a transaction that invokes the program:

```yaml
  transactions:
    - name: HELO
      program: HELLO
    
    # Add the new transaction
    - name: MYTR
      program: MYPROG
```

### Step 4: Redeploy

Run the Ansible playbook with specific tags:

```bash
# Compile and deploy the new program
ansible-playbook site.yaml --tags compile,programs
```

### Supported Languages

The automation supports multiple programming languages:

**COBOL**:
```yaml
- name: INQUIRY
  language: cobol
  source_file: programs/INQUIRY.cbl
```

**PL/I**:
```yaml
- name: ACCOUNT
  language: pli
  source_file: programs/ACCOUNT.pli
```

**C**:
```yaml
- name: CUSTOMER
  language: c
  source_file: programs/CUSTOMER.c
```

**C++**:
```yaml
- name: INVOICE
  language: cpp
  source_file: programs/INVOICE.cpp
```

**Assembler**:
```yaml
- name: PAYMENT
  language: asm
  source_file: programs/PAYMENT.asm
```

**REXX**:
```yaml
- name: REPORT
  language: rexx
  source_file: programs/REPORT.rexx
```

## Adding New Bundles

### Step 1: Create Bundle ZIP

Create the OSGi bundle as a ZIP file following CICS bundle structure:

```
mybundle.zip
├── META-INF/
│   └── cics.xml
└── [bundle contents]
```

### Step 2: Add Bundle File

Copy the bundle ZIP to `roles/cics_config/files/bundles/`:

```bash
cp mybundle.zip roles/cics_config/files/bundles/
```

### Step 3: Update cics_resources.yml

Add the bundle definition:

```yaml
  bundles:
    - name: TERMINAL
      source_file: bundles/terminal.zip
    - name: VSAM
      source_file: bundles/vsam.zip
    
    # Add the new bundle
    - name: MYBUNDLE
      source_file: bundles/mybundle.zip
```

### Step 4: Redeploy

```bash
# Deploy the new bundle
ansible-playbook site.yaml --tags bundles
```

## Adding New VSAM Files

### Step 1: Update cics_resources.yml

Add the file definition:

```yaml
  files:
    - name: EXAMPLE
      dsname: CICS.EXAMPLE.DATA
      add: true
      browse: true
      delete: true
      read: true
      update: true
    
    # Add the new file
    - name: MYFILE
      dsname: CICS.MYFILE.DATA
      add: true
      browse: true
      delete: true
      read: true
      update: true
```

### Step 2: Redeploy

```bash
# Deploy the new file
ansible-playbook site.yaml --tags files
```

### File Permissions

Available permissions:
- **add**: Allow record addition
- **browse**: Allow record browsing
- **delete**: Allow record deletion
- **read**: Allow record reading
- **update**: Allow record updating

## Deploying to Multiple Regions

### Option 1: Set Variable in defaults/main.yml

Edit `roles/cics_config/defaults/main.yml`:

```yaml
# Deploy to specific regions
deploy_regions: ["CICS62", "CICSAOR1"]
```

### Option 2: Command Line Override

```bash
ansible-playbook site.yaml --tags programs \
  -e "deploy_regions=['CICS62','CICSAOR1']"
```

### Option 3: Deploy to All Regions

Leave `deploy_regions` empty to deploy to all discovered regions:

```yaml
deploy_regions: []
```

## Custom CSD Scripts

For advanced CICS configuration, CSD scripts can be used.

### Step 1: Create CSD Script

Create a script in `roles/cics_config/files/csd_scripts/`:

```
# mycsd.txt
DEFINE PROGRAM(MYPROG) GROUP(MYGROUP) LANGUAGE(COBOL)
DEFINE TRANSACTION(MYTR) GROUP(MYGROUP) PROGRAM(MYPROG)
INSTALL GROUP(MYGROUP)
```

### Step 2: Enable CSD Scripts

Edit `roles/cics_config/defaults/main.yml`:

```yaml
apply_csd_scripts: true
```

### Step 3: Run Deployment

```bash
ansible-playbook site.yaml --tags csd
```

## Modifying Zconfig Files

### Pre-Tailoring Zconfig

Zconfig files should be pre-tailored before committing to the repository.

**Tailoring Script** (reference only, run locally):

```bash
python3 tailor_zconfig.py zconfig/cics62.yaml \
  --le-hlq SYS1.CEE \
  --usshome /usr/lpp/cicsts/cicsts62 \
  --region-base /var/cicsts/regions \
  --volumes CICS62 \
  --cicssvc 216
```

### Zconfig File Structure

Example `cics62.yaml`:

```yaml
applid: CICS62
region_base: /var/cicsts/regions
usshome: /usr/lpp/cicsts/cicsts62
cmci_port: 10080
cicssvc: 216
# ... additional configuration
```

### Adding New Regions

To add a new CICS region:

1. Create new zconfig file: `cics_aor1.yaml`
2. Update `defaults/main.yml`:
   ```yaml
   zconfig_files_to_apply:
     - cics62
     - cics_aor1
   ```
3. Redeploy: `ansible-playbook site.yaml --tags regions`

## Customizing Region Settings

### Modify Default Variables

Edit `roles/cics_config/defaults/main.yml`:

```yaml
# Region configuration
cics_region_userid: CICSPRD
cics_default_user: CICSUSER
cics_region_base: /var/cicsts/regions

# Performance tuning
cics_maxtasks: 999
cics_mxt: 999
cics_edsalim: 500M
cics_dsalim: 500M

# JVM settings
cics_jvm_xms: 512M
cics_jvm_xmx: 2048M
```

### Override via Command Line

```bash
ansible-playbook site.yaml \
  -e "cics_maxtasks=1500" \
  -e "cics_jvm_xmx=4096M"
```

## Testing Your Changes

### Compile Only

Test compilation without deployment:

```bash
ansible-playbook site.yaml --tags compile --check
```

### Deploy to Test Region

Deploy to a specific test region:

```bash
ansible-playbook site.yaml --tags programs \
  -e "deploy_regions=['CICSTEST']"
```

### Verify Deployment

Check that resources are defined:

```bash
# Via CMCI
curl -u CICSUSER:password \
  http://<zos-ip>:10080/CICSSystemManagement/CICSDefinitionProgram/CICS62?CRITERIA=(NAME=MYPROG)
```

## Best Practices

### Program Development

1. **Test locally** - Compile and test programs before adding to automation
2. **Use meaningful names** - Program and transaction names should be descriptive
3. **Document resources** - Add comments in cics_resources.yml
4. **Version control** - Commit changes to git with clear messages

### Bundle Development

1. **Follow CICS bundle structure** - Include proper META-INF/cics.xml
2. **Test bundle contents** - Verify bundle extracts correctly
3. **Check dependencies** - Ensure all required files are included
4. **Document bundle purpose** - Add README in bundle directory

### Deployment Strategy

1. **Test in dev first** - Deploy to development region before production
2. **Use tags** - Deploy specific components with --tags
3. **Verify each step** - Check logs and CMCI after deployment
4. **Keep backups** - Save working configurations before changes

## Rollback Procedures

### Rollback Program Changes

1. Revert changes in git:
   ```bash
   git revert <commit-hash>
   ```

2. Redeploy:
   ```bash
   ansible-playbook site.yaml --tags compile,programs
   ```

### Rollback Bundle Changes

1. Remove bundle from cics_resources.yml
2. Redeploy:
   ```bash
   ansible-playbook site.yaml --tags bundles
   ```

### Rollback Region Changes

1. Revert zconfig file changes
2. Recreate region:
   ```bash
   ansible-playbook site.yaml --tags regions \
     -e "cics_recreate_regions=true"
   ```

## Advanced Customization

### Custom Ansible Tasks

Add custom tasks to `roles/cics_config/tasks/`:

```yaml
# custom_config.yml
- name: Custom CICS configuration
  ibm.ibm_zos_core.zos_mvs_raw:
    program_name: IDCAMS
    parm: "DEFINE CLUSTER(...)"
```

Include in main.yml:

```yaml
- name: Run custom configuration
  ansible.builtin.include_tasks: custom_config.yml
  when: run_custom_config | default(false)
```

### Custom Resource Types

Extend cics_resources.yml with custom resource types:

```yaml
cics_resources:
  programs: [...]
  transactions: [...]
  files: [...]
  bundles: [...]
  
  # Custom resources
  custom_resources:
    - type: URIMAP
      name: MYURI
      path: /myapp
```

## Getting Help

- **Customization Issues**: Check Ansible playbook logs
- **Compilation Errors**: Review compile output in AAP
- **Deployment Failures**: Verify CMCI connectivity and credentials
- **Zconfig Issues**: Run `zconfig ls` and check region logs

## Next Steps

- **[Troubleshooting](./troubleshooting)** - Common customization issues
- **[Technical Reference](./reference)** - Complete variable and format reference
- **[Deployment Process](./deployment-process)** - Understanding the deployment flow