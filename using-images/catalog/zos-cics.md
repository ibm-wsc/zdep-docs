# z/OS Standard + CICS

A fully configured z/OS environment with CICS Transaction Server for transaction processing demonstrations.

## Overview

This demo image provides a complete CICS TS 6.2 environment on z/OS, ready for demonstrating enterprise transaction processing, application modernization, and web services integration. The image includes sample applications, pre-configured regions, and demonstration scenarios.

**Key Value Proposition:**
- Demonstrate CICS transaction processing capabilities
- Show application modernization paths
- Highlight web services and API integration
- Showcase CICS security and scalability features

## What's Included

### Software Components

- **CICS Transaction Server 6.2** - Latest CICS TS release
- **z/OS Base System** - Standard z/OS configuration
- **VSAM** - Virtual Storage Access Method for data storage
- **Db2 for z/OS** - Relational database integration
- **IBM MQ** - Message queuing for integration
- **RACF** - Security configuration

### Pre-configured CICS Regions

- **CICSRG01** - Primary transaction region
- **CICSWEB1** - Web services region
- **CICSDEV1** - Development and testing region

### Sample Applications

#### COBOL Programs
- **HELLO** - Simple "Hello World" transaction
- **INQUIRY** - Customer inquiry application
- **ACCOUNT** - Account management (PL/I)
- **CUSTOMER** - Customer data access (C)
- **INVOICE** - Invoice processing (C++)
- **PAYMENT** - Payment processing (Assembler)

#### Web Services
- RESTful API examples
- JSON/XML processing
- Service orchestration
- Error handling patterns

#### VSAM Files
- Customer master file
- Account transaction file
- Product catalog
- Order history

### Pre-defined Transactions

| Transaction | Description | Program |
|-------------|-------------|---------|
| HELLO | Hello World demo | HELLO |
| INQC | Customer inquiry | INQUIRY |
| ACCT | Account management | ACCOUNT |
| CUST | Customer data | CUSTOMER |
| INVP | Invoice processing | INVOICE |
| PYMT | Payment processing | PAYMENT |

## Demo Scenarios

### Scenario 1: Transaction Processing Demo (15-20 minutes)

Demonstrate CICS transaction processing capabilities with sample applications.

**What to Show:**
1. Connect to CICS via 3270 terminal
2. Execute HELLO transaction
3. Show customer inquiry (INQC)
4. Demonstrate VSAM file access
5. Display transaction statistics

**Key Points:**
- Sub-second response times
- Concurrent transaction processing
- Data integrity and consistency
- Security and access control

**Business Value:**
- High-performance transaction processing
- Scalability for enterprise workloads
- Proven reliability and availability
- Cost-effective operations

### Scenario 2: Web Services Integration (20-30 minutes)

Show how CICS integrates with modern web services and APIs.

**What to Show:**
1. Access CICS via RESTful API
2. JSON request/response examples
3. Service orchestration across systems
4. Error handling and recovery
5. Security and authentication

**Key Points:**
- Modern API integration
- Support for JSON and XML
- Seamless legacy integration
- Cloud connectivity

**Business Value:**
- Application modernization without rewrite
- Integration with cloud services
- Mobile and web application support
- Faster time to market

### Scenario 3: Application Modernization (25-35 minutes)

Demonstrate modernization paths for CICS applications.

**What to Show:**
1. Existing COBOL application
2. Add RESTful API interface
3. Integrate with modern UI
4. Show DevOps capabilities
5. Demonstrate continuous deployment

**Key Points:**
- Preserve existing investments
- Incremental modernization approach
- Modern development practices
- Cloud-native integration

**Business Value:**
- Protect existing investments
- Reduce modernization risk
- Accelerate digital transformation
- Lower total cost of ownership

## Getting Started

### Initial Setup

1. **Connect to z/OS**
   - Follow the [Connecting to z/OS](../connecting) guide
   - Ensure VPN connection is established
   - Connect via SSH: `ssh zosadmn@<your-zos-ip>`

2. **Access CICS via 3270 Terminal**
   - Use IBM Host On-Demand or similar emulator
   - Connect to `<your-zos-ip>:2023`
   - Login with TSO credentials

3. **Verify CICS Regions**
   ```
   TSO ZOSADMN
   
   # Check CICS region status
   D A,CICSRG01
   D A,CICSWEB1
   ```

### Quick Demo Path

For a 10-minute quick demo:
1. Connect to CICS region CICSRG01
2. Execute HELLO transaction
3. Run customer inquiry (INQC)
4. Show transaction response time
5. Display CICS statistics

## Configuration Details

### CICS Regions

#### CICSRG01 (Primary Region)
- **Port**: 1490
- **Purpose**: Main transaction processing
- **Programs**: All sample applications
- **Files**: All VSAM files
- **Transactions**: All demo transactions

#### CICSWEB1 (Web Services Region)
- **Port**: 9080 (HTTP), 9443 (HTTPS)
- **Purpose**: RESTful API and web services
- **Features**: JSON/XML support, CMCI enabled
- **Security**: SSL/TLS configured

#### CICSDEV1 (Development Region)
- **Port**: 1491
- **Purpose**: Testing and development
- **Features**: Debug enabled, trace facilities
- **Isolation**: Separate from production demos

### VSAM File Configuration

| File | Type | Records | Purpose |
|------|------|---------|---------|
| CUSTFILE | KSDS | 10,000 | Customer master |
| ACCTFILE | KSDS | 50,000 | Account transactions |
| PRODFILE | KSDS | 1,000 | Product catalog |
| ORDRFILE | ESDS | 25,000 | Order history |

### Security Configuration

- **RACF Profiles**: Pre-configured for demo users
- **Transaction Security**: Class-based authorization
- **Resource Security**: File and program protection
- **SSL/TLS**: Certificates configured for HTTPS

## Tips & Best Practices

### For Effective Demonstrations

1. **Start with Business Context** - Explain why CICS matters
2. **Show Real Transactions** - Use realistic business scenarios
3. **Highlight Performance** - Emphasize sub-second response times
4. **Demonstrate Integration** - Show connections to other systems
5. **Discuss Modernization** - Address legacy concerns proactively

### Common Pitfalls to Avoid

- Don't assume audience knows CICS terminology
- Avoid getting lost in technical details too early
- Don't skip the "why CICS" conversation
- Ensure CICS regions are started before demo
- Have backup scenarios ready

### Performance Considerations

- Pre-warm CICS regions before demonstrations
- Clear transaction logs between demos
- Monitor region storage usage
- Test all transactions before presenting

## Technical Reference

### System Requirements

- **Memory**: 4GB minimum for CICS regions
- **Storage**: 20GB for CICS libraries and files
- **Network**: VPN access required
- **Terminal**: 3270 emulator for CICS access

### CICS Components

| Component | Version | Purpose |
|-----------|---------|---------|
| CICS TS | 6.2 | Transaction server |
| CMCI | Latest | Management interface |
| CPSM | Latest | Performance management |
| CICSPlex SM | Latest | System management |

### Integration Points

- **Db2**: JDBC and native connections
- **MQ**: Message queuing integration
- **z/OS Connect**: RESTful API gateway
- **RACF**: Security integration
- **SMF**: Performance monitoring

## Troubleshooting

### CICS Region Won't Start

```
# Check region status
D A,CICSRG01

# Review CICS messages
F CICSRG01,CEMT I SYS

# Check for storage issues
F CICSRG01,CEMT I DSA
```

### Transaction Fails

- Verify program is defined: `CEMT I PROG(progname)`
- Check transaction definition: `CEMT I TRAN(tranid)`
- Review CICS messages in MSGUSR
- Verify VSAM file status: `CEMT I FILE(filename)`

### Web Services Not Responding

- Check CICSWEB1 region status
- Verify port 9080/9443 accessibility
- Review URIMAP definitions
- Check SSL certificate configuration

### Connection Issues

- Verify VPN connection
- Check firewall rules for port 2023
- Confirm z/OS IP address
- Test SSH connectivity first

## Additional Resources

- [CICS TS 6.2 Documentation](https://www.ibm.com/docs/en/cics-ts)
- [CICS Application Programming Guide](https://www.ibm.com/docs/en/cics-ts/6.2?topic=programming)
- [Connecting to z/OS](../connecting)
- [FAQs](../../reference/faqs)

## Support

For technical issues or questions:
- **TechZone Support**: For provisioning and access issues
- **WSC Team**: For demo content and scenarios
- **IBM Documentation**: For CICS-specific questions
- **Slack**: [#wsc-demo-hosting-in-techzone-workstreams](https://ibm.enterprise.slack.com/archives/C08K4MKMMKK)