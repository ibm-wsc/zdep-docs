# CICS Configuration Details

This page provides detailed configuration information for the CICS demo image components.

## System Setup

The CICS configuration is automated via the `cics_config` Ansible role.

### Volume Configuration

- **Volume**: USMS01
- **Purpose**: CICS data storage
- **Management**: SMS-managed storage
- **VTOC**: Indexed for performance
- **Creation**: Automated via `system_setup.yml`

### SMS Configuration

- **Storage group**: STANDARD
- **SCDS**: LTEPLEX.SMS.SCDS (Source Control Data Set)
- **ACDS**: LTEPLEX.SMS.ACDS (Active Control Data Set)
- **Volume management**: Automatic via SMS
- **Data class**: Default SMS data class

### VTAM Configuration

**APPL Definitions** (SYS1.VTAMLST(APPLCICS)):
- CICS region APPL statements
- ATCCON configuration in SYS1.VTAMLST(ATCCON00)
- **EAS**: 45 (Estimated Active Sessions)
- **VPACING**: 5 (Virtual pacing)
- **MODETAB**: ISTINCLM (Mode table)

### Log Streams

**System Log**:
- **Name**: `CICSPRD.CICS62.DFHLOG`
- **Type**: LOGR (System Logger)
- **Storage**: DASD-only
- **Log stream size**: 4096 KB
- **Storage size**: 3072 KB

**Forward Recovery Log**:
- **Name**: `CICSPRD.CICS62.DFHFWDRECOV`
- **Type**: LOGR (System Logger)
- **Storage**: DASD-only
- **Purpose**: Forward recovery of VSAM files

## Security Configuration

### CICS SVC

- **SVC number**: 216
- **Program**: DFHCSVCU
- **Entry point**: DFHCSVC
- **Installation**: SYS1.PARMLIB(IEASVC00)
- **LPA list**: SYS1.PARMLIB(LPALST00)
- **Purpose**: CICS system services

### Liberty Angel

**User Configuration**:
- **User ID**: BBGZANGL
- **UID**: 9999
- **Group**: SYS1
- **Home**: /u/bbgzangl
- **Shell**: /bin/sh

**Procedure** (SYS1.PROCLIB(BBGZANGL)):
- **Angel name**: CICSANGL
- **Program**: BBOAGENT
- **Purpose**: Liberty JVM server support

### RACF Profiles

**Angel Profile**:
```
RDEFINE STARTED BBG.ANGEL.CICSANGL STDATA(USER(BBGZANGL) GROUP(SYS1))
```

**Authorization Modules**:
```
RDEFINE FACILITY BBG.AUTHMOD.BBGZSAFM.SAFCRED UACC(NONE)
RDEFINE FACILITY BBG.AUTHMOD.BBGZSAFM.PRODMGR UACC(NONE)
RDEFINE FACILITY BBG.AUTHMOD.BBGZSAFM.ZOSAIO UACC(NONE)
RDEFINE FACILITY BBG.AUTHMOD.BBGZSAFM.ZOSWLM UACC(NONE)
RDEFINE FACILITY BBG.AUTHMOD.BBGZSAFM.ZOSDUMP UACC(NONE)
```

**Security Prefix**:
```
RDEFINE FACILITY BBG.SECPFX.* UACC(NONE)
```

### SSL/TLS Configuration

**Keyring**:
- **Name**: CICSRING
- **Owner**: CICSPRD (region userid)
- **Purpose**: SSL/TLS certificates for CICS

**Certificates**:
- **Type**: Self-signed (for demo purposes)
- **Label**: CICSCERT
- **Algorithm**: RSA 2048-bit
- **Validity**: 365 days
- **Connected to**: CICSRING

**Certificate Commands**:
```
RACDCERT GENCERT ID(CICSPRD) +
  SUBJECTSDN(CN('CICS Demo') O('IBM') C('US')) +
  WITHLABEL('CICSCERT') +
  KEYUSAGE(HANDSHAKE) +
  SIZE(2048) +
  NOTAFTER(DATE(2027-12-31))

RACDCERT CONNECT(CERTAUTH LABEL('CICSCERT')) +
  ID(CICSPRD) RING(CICSRING)
```

## CICS Installation

### Installation Datasets

- **Volume**: CICS62
- **User Catalog**: CATALOG.CICS62
- **SDFHAUTH**: CICS62.CICS.SDFHAUTH (Authorized libraries)
- **SDFHLIC**: CICS62.CICS.SDFHLIC (License libraries)
- **SDFHLPA**: CICS62.CICS.SDFHLPA (LPA libraries)
- **SEYUAUTH**: CICS62.CPSM.SEYUAUTH (CICSPlex SM)

### USS Paths

- **USSHOME**: `/usr/lpp/cicsts/cicsts62`
- **Region base**: `/var/cicsts/regions`
- **USS config**: `/var/cicsts/dfhconfig`
- **JVM profiles**: `/var/cicsts/JVMProfiles`
- **Bundles**: `/var/cicsts/cics_bundles`

### Java Configuration

- **Java home**: `/usr/lpp/java/J21.0_64`
- **Java version**: Java 21 (64-bit)
- **Liberty**: `/usr/lpp/cicsts/cicsts62/wlp`
- **Liberty version**: Embedded with CICS TS 6.2

## Region Configuration

### Region Settings

From `defaults/main.yml`:

- **Region userid**: CICSPRD
- **Default user**: CICSUSER
- **End user**: ZOSADMN
- **LE HLQ**: SYS1.CEE (Language Environment)
- **MYSIT**: SIT$R1F5 (System Initialization Table)
- **SYSID**: CICT (System ID)
- **Region size**: 0M (dynamic)
- **MEMLIM**: 15G (Memory limit)
- **CICSSVC**: 216

### Zconfig Deployment

- **Zconfig version**: 0.4.0
- **Zconfig command**: `~/.local/bin/zconfig`
- **Zconfig files**: `/u/zosadmn/zconfigs/`
- **Configuration**: Pre-tailored for environment
- **Deployment**: Automatic region creation and startup

### Region Startup

**Zconfig Commands**:
```bash
# Apply configuration
~/.local/bin/zconfig apply /u/zosadmn/zconfigs/cics62.yaml

# Start region
~/.local/bin/zconfig start CICS62

# Check status
~/.local/bin/zconfig ls

# View logs
~/.local/bin/zconfig logs CICS62
```

## CMCI Configuration

### CMCI Settings

- **Port**: Extracted from zconfig (typically 10080-10090)
- **Protocol**: HTTP (HTTPS optional)
- **Authentication**: Basic (userid/password)
- **Default user**: CICSUSER
- **API endpoint**: `/CICSSystemManagement`

### CMCI API Structure

**Base URL**:
```
http://<zos-ip>:<cmci-port>/CICSSystemManagement
```

**Resource Types**:
- `/CICSRegion/<applid>` - Region information
- `/CICSDefinitionProgram/<applid>` - Program definitions
- `/CICSDefinitionTransaction/<applid>` - Transaction definitions
- `/CICSDefinitionFile/<applid>` - File definitions
- `/CICSDefinitionBundle/<applid>` - Bundle definitions

## Storage Configuration

### Dataset Allocation

**Source Library** (CICS62.CICS.SOURCE):
- **Organization**: PO (Partitioned)
- **Record format**: FB (Fixed Block)
- **Record length**: 80
- **Block size**: 27920
- **Space**: (10,10) tracks

**Load Library** (CICS62.CICS.LOADLIB):
- **Organization**: PO (Partitioned)
- **Record format**: U (Undefined)
- **Record length**: 0
- **Block size**: 32760
- **Space**: (50,20) tracks

### VSAM Configuration

**Example File** (CICS.EXAMPLE.DATA):
- **Organization**: KSDS (Key-Sequenced Data Set)
- **Key length**: 8
- **Record length**: 80
- **Space**: (10,10) tracks
- **Shareoptions**: (2,3)

## Network Configuration

### TCP/IP Settings

- **z/OS IP**: Assigned during provisioning
- **CMCI port**: From zconfig (10080-10090 range)
- **TN3270 port**: 2023 (standard)
- **HTTP port**: 80 (if web interface enabled)
- **HTTPS port**: 443 (if SSL/TLS enabled)

### Firewall Rules

Required ports for CICS access:
- **2023**: TN3270 terminal access
- **10080-10090**: CMCI API access
- **80/443**: Web interface (optional)

## Performance Tuning

### Region Parameters

- **MAXTASKS**: 999 (Maximum concurrent tasks)
- **MXT**: 999 (Maximum number of tasks)
- **AKPFREQ**: 5000 (Autoinstall frequency)
- **EDSALIM**: 500M (Extended DSA limit)
- **DSALIM**: 500M (DSA limit)

### JVM Configuration

**JVM Profile** (/var/cicsts/JVMProfiles/DFHJVMPR):
```
-Xms512M
-Xmx2048M
-Xgcpolicy:gencon
-Xverbosegclog:/var/cicsts/regions/CICS62/logs/gc.log
```

## Monitoring and Logging

### Log Locations

**Region Logs**:
- **MSGUSR**: `/var/cicsts/regions/<APPLID>/logs/MSGUSR`
- **MSGOUT**: `/var/cicsts/regions/<APPLID>/logs/MSGOUT`
- **STDERR**: `/var/cicsts/regions/<APPLID>/logs/STDERR`
- **STDOUT**: `/var/cicsts/regions/<APPLID>/logs/STDOUT`

**JVM Logs**:
- **GC log**: `/var/cicsts/regions/<APPLID>/logs/gc.log`
- **JVM log**: `/var/cicsts/regions/<APPLID>/logs/jvmtrace.log`

### Monitoring Commands

**Check region status**:
```bash
~/.local/bin/zconfig ls
```

**View region logs**:
```bash
tail -f /var/cicsts/regions/CICS62/logs/MSGUSR
```

**Check CMCI**:
```bash
curl -u CICSUSER:password \
  http://<zos-ip>:10080/CICSSystemManagement/CICSRegion/CICS62
```

## Next Steps

- **[Customization Guide](./customization)** - Modify configuration as needed
- **[Troubleshooting](./troubleshooting)** - Common configuration issues
- **[Technical Reference](./reference)** - Complete variable reference