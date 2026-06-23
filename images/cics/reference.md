# CICS Technical Reference

Technical reference information for the CICS demo image configuration.

## CICS Regions

### Region Names and Ports

| Region Name | CMCI Port | Description |
|-------------|-----------|-------------|
| CICSRG01 | 10001 | Primary CICS region |
| CICSRG02 | 10002 | Secondary CICS region |

### Region Configuration

Each CICS region is configured with:
- **APPLID**: Unique application identifier
- **CMCI Port**: Management interface port
- **VTAM**: Virtual Telecommunications Access Method integration
- **Log Streams**: System and user log streams
- **Security**: RACF integration with SSL/TLS

## Dataset Names

### System Datasets

- **CICS.V6R2.SDFHLOAD**: CICS load library
- **CICS.V6R2.SDFHAUTH**: CICS authorized library
- **CICS.CUSTOM.LOAD**: Custom program load library
- **CICS.CUSTOM.BUNDLE**: Bundle deployment directory

### User Datasets

- **CICS.USER.PROGRAMS**: User program source
- **CICS.USER.VSAM**: VSAM file definitions
- **CICS.USER.LOGS**: Application logs

## Security Profiles

### RACF Profiles

```
CICSRG01.** - Region resource protection
CICSRG01.CMCI - CMCI access control
CICSRG01.BUNDLE - Bundle deployment access
```

### SSL/TLS Configuration

- **Keyring**: CICSRG01RING
- **Certificate**: Self-signed for demo purposes
- **Protocols**: TLSv1.2, TLSv1.3

## Network Configuration

### Ports

| Service | Port | Protocol |
|---------|------|----------|
| CMCI | 10001-10002 | HTTPS |
| CICS Web | 9080-9081 | HTTP |
| CICS Secure Web | 9443-9444 | HTTPS |

### Hostnames

- Primary: `cicsrg01.demo.ibm.com`
- Secondary: `cicsrg02.demo.ibm.com`

## Program Compilation

### Supported Languages

- **COBOL**: Enterprise COBOL for z/OS
- **PL/I**: Enterprise PL/I for z/OS
- **C**: IBM C/C++ for z/OS
- **C++**: IBM C/C++ for z/OS
- **Assembler**: High Level Assembler

### Compilation Options

Default compilation options are configured in the zconfig YAML files:
- COBOL: `RENT,APOST,NODYNAM`
- PL/I: `RENT,LIMITS(EXTNAME(31))`
- C/C++: `RENT,LONGNAME,DLL`

## VSAM Files

### File Definitions

Sample VSAM files included:
- **CUSTOMER**: Customer master file (KSDS)
- **ACCOUNT**: Account transaction file (KSDS)
- **INVOICE**: Invoice history file (KSDS)

### File Attributes

- **Record Size**: Variable (up to 32KB)
- **Key Length**: 8 bytes
- **CI Size**: 4096 bytes
- **CA Size**: 1 cylinder

## Bundle Deployment

### Bundle Types

- **OSGi**: Java OSGi bundles
- **WAR**: Web application archives
- **EAR**: Enterprise application archives

### Deployment Directory

Bundles are deployed to: `/u/cics/bundles/`

## API Endpoints

### CMCI REST API

Base URL: `https://<zos-ip>:10001/CICSSystemManagement/`

Common endpoints:
- `/CICSRegion/<region>/CICSProgram` - Program resources
- `/CICSRegion/<region>/CICSFile` - File resources
- `/CICSRegion/<region>/CICSBundle` - Bundle resources

### Authentication

- **Method**: Basic Authentication
- **User**: CICSUSER
- **Password**: Set during deployment

## Log Streams

### System Log Streams

- **DFHLOG**: CICS system log
- **DFHSHUNT**: CICS trace log

### User Log Streams

- **APPLLOG**: Application log stream

## Performance Tuning

### JVM Configuration

- **Heap Size**: 512MB initial, 2GB maximum
- **Thread Pool**: 50 threads

### Transaction Limits

- **Max Tasks**: 500
- **Max Transactions**: 1000/second

## Troubleshooting Reference

### Common Error Codes

| Code | Description | Resolution |
|------|-------------|------------|
| DFHAC2001 | Transaction abend | Check application logs |
| DFHPI1008 | Program not found | Verify program definition |
| DFHFC0001 | File not found | Check file definition |

### Log Locations

- System logs: `/var/cics/logs/`
- Application logs: `/u/cics/applogs/`
- JVM logs: `/u/cics/jvmlogs/`

## Related Documentation

- [CICS Overview](./overview.md)
- [Configuration Details](./configuration.md)
- [Troubleshooting Guide](./troubleshooting.md)