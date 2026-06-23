# Connecting to Your Instance

Learn how to connect to the provisioned z/OS demo instance.

## Prerequisites

Before connecting, ensure the following are available:
- Provisioned z/OS instance from TechZone
- WSC VPN credentials
- z/OS IP address (provided after provisioning)
- 3270 terminal emulator installed

## Connection Steps

### 1. Connect to WSC VPN

Use Cisco AnyConnect to connect to the WSC VPN:

1. Open Cisco AnyConnect
2. Enter VPN address: `ssl.wsc.ihost.com`
3. Enter the WSC VPN credentials
4. Click Connect

### 2. Launch Terminal Emulator

Open the 3270 terminal emulator (e.g., IBM Host On-Demand)

### 3. Configure Connection

Create a new connection with these settings:
- **Host**: The z/OS IP address (from provisioning email)
- **Port**: `2023`
- **Terminal Type**: IBM-3278-2

### 4. Connect to TSO

Once connected, log in to TSO:

```
TSO ZOSADMN
```

Enter the password when prompted.

## Troubleshooting

### Cannot Connect to VPN
- Verify the WSC VPN credentials are correct
- Ensure the correct VPN address is being used
- Check that Cisco AnyConnect is up to date

### Cannot Reach z/OS IP
- Confirm connection to WSC VPN
- Verify the IP address is correct
- Check that the instance is running (not stopped)

### TSO Login Fails
- Verify the correct username is being used (ZOSADMN)
- Ensure the password was set correctly during provisioning
- Try resetting the password if needed

## Next Steps

- [Demo Scenarios](./demo-scenarios) - Start running demonstrations
- [FAQs](../reference/faqs) - Common questions and answers