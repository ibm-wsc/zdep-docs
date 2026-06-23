# CICS Troubleshooting

This page provides solutions to common issues encountered with the CICS demo image.

## CICS Region Issues

### Region Not Starting

**Symptoms**:
- Zconfig shows region as "STOPPED" or "FAILED"
- Region doesn't appear in `zconfig ls` output
- No CICS messages in system log

**Check zconfig status**:
```bash
ssh zosadmn@<zos-ip>
cd /u/zosadmn
./.local/bin/zconfig ls
```

**View region logs**:
```bash
tail -f /var/cicsts/regions/<APPLID>/logs/MSGUSR
```

**Common Causes**:

1. **CICS SVC not installed**
   ```bash
   # Check SVC 216 is installed
   tsocmd "D PROG,LNKLST"
   ```
   **Solution**: Verify IEASVC00 contains SVC 216 entry

2. **Liberty Angel not started**
   ```bash
   # Check Angel process
   tsocmd "D A,BBGZANGL"
   ```
   **Solution**: Start Angel: `S BBGZANGL`

3. **Log streams not defined**
   ```bash
   # Check log streams
   tsocmd "D LOGGER,LOGSTREAM,LSN=CICSPRD.CICS62.*"
   ```
   **Solution**: Rerun system_setup.yml task

4. **Insufficient storage**
   - Check MEMLIM setting in zconfig
   - Verify z/OS has available storage
   - Review region size parameters

### Region Abends

**Check abend code**:
```bash
# View MSGUSR log
tail -100 /var/cicsts/regions/CICS62/logs/MSGUSR | grep DFHAC
```

**Common Abend Codes**:

- **ASRA** - Program check (bad code)
  - Check program compilation
  - Verify program logic
  - Review STDERR log

- **AICA** - Runaway task
  - Check for infinite loops
  - Review task timeout settings
  - Increase ICVR value

- **AKCP** - Storage violation
  - Check EDSALIM/DSALIM settings
  - Review storage usage
  - Increase region storage

### Region Performance Issues

**Symptoms**:
- Slow transaction response
- High CPU usage
- Storage shortages

**Check region statistics**:
```bash
# Via CMCI
curl -u CICSUSER:password \
  http://<zos-ip>:10080/CICSSystemManagement/CICSRegion/CICS62
```

**Solutions**:
1. Increase MAXTASKS
2. Adjust DSA limits
3. Tune JVM heap size
4. Review transaction workload

## CMCI Connection Issues

### CMCI Connection Failures

**Symptoms**:
- Cannot connect to CMCI API
- HTTP 401 or 403 errors
- Connection timeout

**Verify CMCI port**:
```bash
# On z/OS
grep cmci_port /u/zosadmn/zconfigs/cics62.yaml
```

**Test CMCI connectivity**:
```bash
curl -u CICSUSER:password \
  http://<zos-ip>:<cmci-port>/CICSSystemManagement
```

**Common Causes**:

1. **Firewall blocking CMCI port**
   - Verify port is open in firewall
   - Check network connectivity
   - Test from different host

2. **CMCI not enabled in region**
   - Check zconfig has cmci_port defined
   - Verify CMCI started in region
   - Review CMCI configuration

3. **Incorrect credentials**
   - Verify userid exists in RACF
   - Check password is correct
   - Ensure user has CICS access

### CMCI API Errors

**HTTP 400 - Bad Request**:
- Check JSON syntax
- Verify resource names
- Review API documentation

**HTTP 404 - Not Found**:
- Verify region name (APPLID)
- Check resource exists
- Confirm CSD group installed

**HTTP 500 - Internal Server Error**:
- Check CICS region logs
- Verify CMCI configuration
- Review system resources

## Program Issues

### Program Not Found

**Symptoms**:
- Transaction fails with "PROGRAM NOT FOUND"
- DFHAC2001 message in logs

**Check program installation**:
```bash
# Via CMCI
curl -u CICSUSER:password \
  http://<zos-ip>:10080/CICSSystemManagement/CICSDefinitionProgram/CICS62?CRITERIA=(NAME=HELLO)
```

**Verify compilation**:
```bash
# On z/OS
tsocmd "LISTDS 'CICS62.CICS.LOADLIB' MEMBERS"
```

**Common Causes**:

1. **Program not compiled**
   - Check compile logs in AAP
   - Verify source file uploaded
   - Review compilation errors

2. **Program not deployed via CMCI**
   - Check cics_resources.yml
   - Verify CMCI deployment succeeded
   - Review deployment logs

3. **CSD group not installed**
   - Check ZCONFIG group installed
   - Verify program in correct group
   - Install group if needed

### Program Compilation Errors

**COBOL Errors**:
```
IEW2278E  XXXX UNRESOLVED EXTERNAL REFERENCE
```
**Solution**: Check SYSLIB concatenation, verify copybooks

**PL/I Errors**:
```
IBM1234I S  UNDECLARED IDENTIFIER
```
**Solution**: Check variable declarations, include files

**C/C++ Errors**:
```
CCN3045  Undeclared identifier
```
**Solution**: Check header files, library paths

## Transaction Issues

### Transaction Not Defined

**Symptoms**:
- "TRANSACTION NOT FOUND" message
- DFHAC2001 error

**Check transaction definition**:
```bash
# Via CMCI
curl -u CICSUSER:password \
  http://<zos-ip>:10080/CICSSystemManagement/CICSDefinitionTransaction/CICS62?CRITERIA=(NAME=HELO)
```

**Verify in cics_resources.yml**:
```yaml
transactions:
  - name: HELO
    program: HELLO
```

**Common Causes**:

1. **Transaction not in cics_resources.yml**
   - Add transaction definition
   - Redeploy with --tags transactions

2. **CMCI deployment failed**
   - Check deployment logs
   - Verify CMCI connectivity
   - Review error messages

3. **CSD group not installed**
   - Install ZCONFIG group
   - Verify transaction in group

### Transaction Abends

**Check transaction status**:
```bash
# Via CMCI
curl -u CICSUSER:password \
  http://<zos-ip>:10080/CICSSystemManagement/CICSLocalTransaction/CICS62?CRITERIA=(TRANID=HELO)
```

**Review abend information**:
- Check MSGUSR log
- Review STDERR output
- Examine dump if available

## Bundle Issues

### Bundle Not Installing

**Symptoms**:
- Bundle shows as DISABLED
- Bundle deployment fails
- DFHPI messages in log

**Check bundle status**:
```bash
# Via CMCI
curl -u CICSUSER:password \
  http://<zos-ip>:10080/CICSSystemManagement/CICSDefinitionBundle/CICS62?CRITERIA=(NAME=TERMINAL)
```

**Common Causes**:

1. **Bundle ZIP corrupt**
   - Verify ZIP file integrity
   - Check bundle structure
   - Recreate ZIP if needed

2. **Missing cics.xml**
   - Verify META-INF/cics.xml exists
   - Check XML syntax
   - Review bundle manifest

3. **Liberty not started**
   - Check Angel process running
   - Verify JVM server started
   - Review JVM logs

### Bundle Runtime Errors

**Check JVM logs**:
```bash
tail -f /var/cicsts/regions/CICS62/logs/jvmtrace.log
```

**Common Issues**:
- ClassNotFoundException - Check bundle contents
- OutOfMemoryError - Increase JVM heap
- NoClassDefFoundError - Check dependencies

## File Issues

### VSAM File Not Found

**Symptoms**:
- File access fails
- DFHFC0001 error

**Check file definition**:
```bash
# Via CMCI
curl -u CICSUSER:password \
  http://<zos-ip>:10080/CICSSystemManagement/CICSDefinitionFile/CICS62?CRITERIA=(NAME=EXAMPLE)
```

**Verify dataset exists**:
```bash
tsocmd "LISTDS 'CICS.EXAMPLE.DATA'"
```

**Common Causes**:
1. Dataset not allocated
2. File not defined in CICS
3. Incorrect dataset name
4. Insufficient permissions

## Zconfig Issues

### Zconfig Command Not Found

**Symptoms**:
- `zconfig: command not found`
- Cannot run zconfig commands

**Check installation**:
```bash
ls -la ~/.local/bin/zconfig
```

**Verify Python path**:
```bash
which python3
python3 --version
```

**Solution**:
```bash
# Reinstall zconfig
pip3 install --user zconfig-0.4.0-py3-none-any.whl
```

### Zconfig Apply Fails

**Check zconfig syntax**:
```bash
~/.local/bin/zconfig validate /u/zosadmn/zconfigs/cics62.yaml
```

**Review error messages**:
- YAML syntax errors
- Missing required fields
- Invalid values

**Common Issues**:
1. Incorrect YAML indentation
2. Missing required parameters
3. Invalid file paths
4. Insufficient permissions

## Deployment Issues

### Ansible Playbook Failures

**Check AAP job logs**:
- Review task output
- Check error messages
- Verify connectivity

**Common Failures**:

1. **SSH connection timeout**
   - Verify z/OS IP address
   - Check VPN connection
   - Test SSH manually

2. **ZOAU module errors**
   - Verify ZOAU installed
   - Check ZOAU version
   - Review environment variables

3. **Permission denied**
   - Check user permissions
   - Verify sudo access
   - Review RACF profiles

### Phase 1 vs Phase 2 Issues

**Phase 1 (z/OS) Issues**:
- System setup failures
- Compilation errors
- Zconfig problems

**Phase 2 (CMCI) Issues**:
- IP discovery failures
- CMCI connection errors
- Deployment failures

**Debugging**:
```bash
# Check which phase failed
# Review AAP workflow visualizer
# Examine task-specific logs
```

## Performance Troubleshooting

### High CPU Usage

**Check region CPU**:
```bash
# Via CMCI
curl -u CICSUSER:password \
  http://<zos-ip>:10080/CICSSystemManagement/CICSRegion/CICS62
```

**Solutions**:
1. Review transaction workload
2. Check for runaway tasks
3. Optimize program logic
4. Adjust dispatching priority

### Storage Issues

**Check storage usage**:
```bash
# View MSGUSR for storage messages
grep DFHSM /var/cicsts/regions/CICS62/logs/MSGUSR
```

**Solutions**:
1. Increase EDSALIM/DSALIM
2. Review storage leaks
3. Adjust region MEMLIM
4. Optimize program storage usage

## Getting Additional Help

### Log Locations

**CICS Logs**:
- MSGUSR: `/var/cicsts/regions/<APPLID>/logs/MSGUSR`
- MSGOUT: `/var/cicsts/regions/<APPLID>/logs/MSGOUT`
- STDERR: `/var/cicsts/regions/<APPLID>/logs/STDERR`

**JVM Logs**:
- JVM trace: `/var/cicsts/regions/<APPLID>/logs/jvmtrace.log`
- GC log: `/var/cicsts/regions/<APPLID>/logs/gc.log`

**Ansible Logs**:
- AAP job output
- Workflow visualizer
- Task-specific logs

### Diagnostic Commands

**Region Status**:
```bash
~/.local/bin/zconfig ls
~/.local/bin/zconfig logs CICS62
```

**CMCI Health Check**:
```bash
curl -u CICSUSER:password \
  http://<zos-ip>:10080/CICSSystemManagement
```

**System Resources**:
```bash
tsocmd "D A,L"  # Active address spaces
tsocmd "D M=CPU"  # CPU usage
tsocmd "D ASM"  # Storage usage
```

### Contact Support

- **CICS Issues**: Check IBM CICS documentation
- **Zconfig Issues**: Review zconfig logs and documentation
- **Automation Issues**: Check AAP job logs
- **Platform Support**: Contact Jacob Emery on Slack

## Next Steps

- **[Configuration Details](./configuration)** - Review configuration settings
- **[Customization Guide](./customization)** - Modify the setup
- **[Technical Reference](./reference)** - Complete reference documentation