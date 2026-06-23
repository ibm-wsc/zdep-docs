# Frequently Asked Questions

Common questions about using WSC z/OS demo images.

## General Questions

### What are WSC z/OS demo images?

WSC z/OS demo images are fully-configured, ready-to-use z/OS environments available through IBM TechZone. Each image includes pre-installed middleware (CICS, Db2, IMS, or MQ), sample applications, and demonstration scenarios.

### Who can use these images?

These images are available to IBM technical sales professionals and authorized business partners for demonstrations, hands-on labs, and proof-of-concept activities.

### How long can I keep an instance?

Instances can be reserved for flexible durations ranging from a few hours to several weeks, depending on business needs and TechZone policies.

### Is there a cost?

Access to demo images through TechZone is provided at no charge for authorized users conducting IBM-related demonstrations and enablement activities.

## Provisioning Questions

### How long does provisioning take?

Typical provisioning time is 15-30 minutes. An email notification is sent when the instance is ready.

### Can I provision multiple instances?

Multiple instances can be provisioned simultaneously, subject to TechZone resource availability and access permissions.

### What if provisioning fails?

If provisioning fails, check TechZone notifications for error details. Common issues include resource availability or configuration errors. Contact support if the problem persists.

## Connection Questions

### I can't connect to the VPN. What should I do?

Verify:
- The correct VPN address is being used: `ssl.wsc.ihost.com`
- WSC VPN credentials are correct
- Cisco AnyConnect is installed and up to date
- The network allows VPN connections

### I can't reach my z/OS IP address

Ensure:
- Connection to the WSC VPN is active
- The IP address is correct (check the provisioning email)
- The instance is running (not stopped or terminated)
- Port 2023 is accessible

### My TSO login fails

Common causes:
- Incorrect username (should be ZOSADMN)
- Wrong password
- Password not set during provisioning
- Instance not fully started

Try resetting the password or reprovisioning if the issue persists.

## Usage Questions

### Can I install additional software?

Demo images come pre-configured with specific middleware. While administrative access is provided, installing additional software may affect the demo scenarios and is generally not recommended.

### Can I modify the configuration?

Full administrative access is provided and configurations can be modified as needed for demonstrations. However, major changes may impact pre-built demo scenarios.

### How do I save my work?

Changes made during a session are preserved on the USER01 volume. However, when the instance is terminated, all changes are lost unless volume preservation is specifically requested.

### Can I extend my reservation?

Reservations can be extended through TechZone, subject to resource availability and maximum duration limits.

## Technical Questions

### What z/OS version is included?

Demo images are based on recent z/OS versions (typically z/OS 3.1 or 3.2). Check the specific image description in TechZone for exact version details.

### What middleware versions are available?

Each image includes current versions of its respective middleware:
- CICS TS 6.2
- Db2 13 for z/OS
- IMS 15.6
- IBM MQ 9.4

### Can I access the Linux layer?

Standard demo images provide z/OS access only. The Linux layer (zADE server) is managed by the platform and not directly accessible to end users.

### How much storage is available?

Each instance includes:
- System volumes (read-only)
- USER01 volume (50 GB, read-write)
- Additional volumes can be requested if needed

## Troubleshooting

### My instance is slow or unresponsive

Try:
- Checking the network connection
- Verifying VPN stability
- Restarting the terminal emulator
- Rebooting the instance (if access is available)

### I see unexpected errors in my demo

- Verify the demo scenario steps are being followed correctly
- Check that required resources (files, programs) exist
- Review z/OS system logs for error details
- Try reprovisioning if the issue persists

### How do I report a problem?

Contact WSC support through:
- TechZone support portal
- WSC Slack channels
- Email to the WSC team

Include:
- Instance name and IP address
- Description of the problem
- Steps to reproduce
- Any error messages

## Best Practices

### Before Your Demo

- Provision the instance at least 1 hour before the demo
- Test the connection and verify all scenarios work
- Have backup plans for technical issues
- Document any custom configurations

### During Your Demo

- Keep scenarios simple and focused
- Allow time for questions and interaction
- Have troubleshooting steps ready
- Monitor time to stay on schedule

### After Your Demo

- Terminate instances that are no longer needed
- Document any issues encountered
- Share feedback with the WSC team
- Consider contributing improvements

## Getting Help

### Support Channels

- **TechZone Support**: For provisioning and access issues
- **WSC Team**: For technical questions and demo guidance
- **Documentation**: This site and linked resources

### Additional Resources

- [Getting Started](../using-images/getting-started) - Initial setup guide
- [Connecting to Your Instance](../using-images/connecting) - Connection instructions
- [Demo Scenarios](../using-images/demo-scenarios) - Pre-built demonstrations