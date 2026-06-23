# What's Included in the CICS Demo Image

This page provides a detailed inventory of all components included in the CICS demo image.

## CICS Regions

The image includes CICS regions deployed via zconfig. The actual regions depend on the zconfig files applied during customization (default: `cics62.yaml`).

### Region Configuration

- Regions defined in `/u/zosadmn/zconfigs/` on z/OS
- CMCI enabled for remote administration
- Automatic startup via zconfig
- Liberty Angel process for Java support

### Default Region

From `cics62.yaml`:

- **APPLID**: CICS62 (or as defined in zconfig)
- **CMCI Port**: Extracted automatically from zconfig
- **Region Base**: `/var/cicsts/regions/`
- **User**: CICSPRD

## Sample Programs

### COBOL Programs

#### HELLO.cbl - Simple "Hello World" Transaction

- **Transaction**: HELO
- **Program**: HELLO
- **Language**: COBOL
- **Location**: `roles/cics_config/files/programs/HELLO.cbl`
- **Compiled to**: `CICS62.CICS.LOADLIB`
- **Deployed via**: CMCI API

### Example Programs

Located in `programs/examples/` (provided as templates, not automatically deployed):

- **INQUIRY.cbl** - Customer inquiry application (COBOL)
- **ACCOUNT.pli** - Account management (PL/I)
- **CUSTOMER.c** - Customer data processing (C)
- **INVOICE.cpp** - Invoice processing (C++)
- **PAYMENT.asm** - Payment processing (Assembler)
- **REPORT.rexx** - Report generation (REXX)

*Note: Example programs are provided as templates but not automatically deployed.*

## Java Bundles

Deployed via CMCI to CICS regions:

### TERMINAL Bundle

- **File**: `terminal.zip`
- **Type**: OSGi bundle
- **Purpose**: Terminal emulation
- **Deployed to**: `/var/cicsts/cics_bundles/`

### VSAM Bundle

- **File**: `vsam.zip`
- **Type**: OSGi bundle
- **Purpose**: VSAM file access
- **Deployed to**: `/var/cicsts/cics_bundles/`

### Example Bundles

Located in `bundles/examples/` (provided as templates, not automatically deployed):

- **link.zip** - Program linking examples
- **serialize.zip** - Data serialization examples
- **tdq.zip** - Transient Data Queue examples
- **tsq.zip** - Temporary Storage Queue examples

*Note: Example bundles are provided as templates but not automatically deployed.*

## VSAM Files

### EXAMPLE File

- **Dataset**: `CICS.EXAMPLE.DATA`
- **Permissions**: Add, Browse, Delete, Read, Update
- **Created via**: CMCI API
- **Defined in**: CSD group ZCONFIG

## Transactions

### HELO Transaction

- **Program**: HELLO
- **Transaction ID**: HELO
- **Defined in**: `cics_resources.yml`
- **Deployed via**: CMCI API
- **CSD Group**: ZCONFIG

## System Components

### CICS Installation

- **Volume**: CICS62
- **User Catalog**: CATALOG.CICS62
- **SDFHAUTH**: CICS62.CICS.SDFHAUTH
- **SDFHLIC**: CICS62.CICS.SDFHLIC
- **SDFHLPA**: CICS62.CICS.SDFHLPA
- **SEYUAUTH**: CICS62.CPSM.SEYUAUTH (CICSPlex SM)

### USS Paths

- **USSHOME**: `/usr/lpp/cicsts/cicsts62`
- **Region base**: `/var/cicsts/regions`
- **USS config**: `/var/cicsts/dfhconfig`
- **JVM profiles**: `/var/cicsts/JVMProfiles`
- **Bundles**: `/var/cicsts/cics_bundles`

### Java Configuration

- **Java home**: `/usr/lpp/java/J21.0_64`
- **Liberty**: `/usr/lpp/cicsts/cicsts62/wlp`

## Security Components

### CICS SVC

- **SVC number**: 216
- **Program**: DFHCSVCU
- **Entry point**: DFHCSVC
- **Installed in**: SYS1.PARMLIB(IEASVC00)
- **LPA list**: SYS1.PARMLIB(LPALST00)

### Liberty Angel

- **Procedure**: BBGZANGL
- **User**: BBGZANGL (UID 9999)
- **Angel name**: CICSANGL
- **PROCLIB**: SYS1.PROCLIB

### RACF Profiles

- `BBG.ANGEL.CICSANGL`
- `BBG.AUTHMOD.BBGZSAFM.*` (SAFCRED, PRODMGR, ZOSAIO, ZOSWLM, ZOSDUMP)
- `BBG.SECPFX.*` (CICS security prefix)

### SSL/TLS Configuration

- **Keyring**: CICSRING
- **Certificates**: Self-signed for demo
- **Connected to**: CICS region userid (CICSPRD)

## Storage Components

### Volume Configuration

- **Volume**: USMS01
- **Purpose**: CICS data storage
- **Management**: SMS-managed
- **VTOC**: Indexed

### SMS Configuration

- **Storage group**: STANDARD
- **SCDS**: LTEPLEX.SMS.SCDS
- **ACDS**: LTEPLEX.SMS.ACDS

### Log Streams

- **System log**: `CICSPRD.CICS62.DFHLOG`
- **Forward recovery**: `CICSPRD.CICS62.DFHFWDRECOV`
- **Data type**: LOGR with DASD-only storage
- **Log stream size**: 4096 KB
- **Storage size**: 3072 KB

## VTAM Configuration

- **APPL definitions**: SYS1.VTAMLST(APPLCICS)
- **ATCCON config**: SYS1.VTAMLST(ATCCON00)
- **EAS**: 45
- **VPACING**: 5
- **MODETAB**: ISTINCLM

## Using These Components

### Connecting to CICS

**Via 3270 Terminal**:
1. Connect to z/OS IP on port 2023
2. Enter transaction ID: `HELO`
3. See "Hello World" message

**Via CMCI API**:
```bash
# Get CMCI port from zconfig (typically 10080-10090 range)
curl -u CICSUSER:password \
  http://<zos-ip>:<cmci-port>/CICSSystemManagement/CICSRegion/CICS62
```

### Running Demo Transactions

**HELO Transaction**:
```
HELO
```
Displays "Hello World" message from HELLO COBOL program.

### Accessing VSAM Files

The EXAMPLE VSAM file is pre-configured and accessible via:
- CICS file control commands
- VSAM bundle (vsam.zip)
- Direct VSAM access

### Working with Bundles

**TERMINAL Bundle**:
- Provides terminal emulation capabilities
- Accessible via CICS web interface

**VSAM Bundle**:
- Demonstrates VSAM file access from Java
- Shows modern integration patterns

## Next Steps

- **[Deployment Process](./deployment-process)** - Learn how these components are deployed
- **[Configuration Details](./configuration)** - Detailed configuration settings
- **[Customization Guide](./customization)** - Add custom programs and bundles