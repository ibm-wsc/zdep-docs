# Request a Worldwide Systems Center VPN ID

This guide walks through obtaining Worldwide Systems Center VPN credentials, which are required for accessing z/OS instances in the Worldwide Systems Center environment.

## Prerequisites

- IBM intranet ID
- Valid business justification for accessing Worldwide Systems Center resources

## Do I Need This?

**Skip this step if:**
- Worldwide Systems Center VPN credentials already exist from previous work
- Connection to `ssl.wsc.ihost.com` is successful

**Continue if:**
- This is the first time working with Worldwide Systems Center resources
- New VPN credentials are needed

---

## Submit Worldwide Systems Center Request Form

Fill out the [Worldwide Systems Center Request Form](https://ibm.biz/wsc-request) using the following guidance:

### Form Fields

| Field | Value |
|-------|-------|
| **Request Title** | Worldwide Systems Center VPN ID Request for [name] |
| **Requestor Name** | [name] |
| **Requestor Email** | [email] |
| **Sales Cloud Opportunity** | N/A |
| **Are there existing contacts in the Worldwide Systems Center?** | No |
| **What kind of request?** | Infrastructure Request |
| **Choose Type of Support** | Access (including new userid) |
| **What type of access?** | New SSL VPN |
| **Justification for SSL VPN** | Access to z/OS guests using zADE automated provisioning for creating demo images for TechZone and technical sales enablement |
| **Hostname / IP Address** | 192.168.32.x |
| **Requested Desired Date** | [Give a few days from today] |

![WSC request form](../assets/image6.png)

### Tips for Justification

Be specific about the use case:
- Mention the purpose is creating demo images for TechZone
- Reference the zADE automated provisioning platform
- Explain the business value (technical sales enablement)

---

## Step 2: Wait for Credentials

### What to Expect

1. **Confirmation Email**: An email will arrive confirming the form submission
2. **Clarifying Questions**: The Worldwide Systems Center infrastructure team may reach out for additional information
3. **Credentials Delivery**: Once approved, someone from the Worldwide Systems Center will provide the credentials

### Timeline

- **Typical Processing Time**: 3-5 business days
- **Rush Requests**: Contact the Worldwide Systems Center directly for urgent needs

### Important: Save Your Credentials

When Worldwide Systems Center VPN credentials are received:

✅ **DO:**
- Save them immediately in a password manager (1Password, LastPass, etc.)
- Test the credentials as soon as they arrive
- Keep a backup in a secure location

❌ **DON'T:**
- Store credentials in plain text files
- Share credentials with others
- Use the same password for multiple systems

---

## Step 3: Test Your VPN Connection

Once credentials are obtained, verify they work:

### Install Cisco AnyConnect

If not already installed:
- **Download**: [Cisco AnyConnect VPN Client](https://www.cisco.com/c/en/us/support/security/anyconnect-secure-mobility-client/tsd-products-support-series-home.html)
- **Install**: Follow the installation wizard for the operating system

### Connect to Worldwide Systems Center VPN

1. Open Cisco AnyConnect
2. Enter the VPN address: `ssl.wsc.ihost.com`
3. Click **Connect**
4. Enter the Worldwide Systems Center VPN credentials when prompted
5. Verify successful connection

### Verify Access

After connecting, test that Worldwide Systems Center resources can be reached:

```bash
# Test connectivity to Worldwide Systems Center network
ping 192.168.32.1
```

If the ping succeeds, the VPN is working correctly!

---

## Troubleshooting

### VPN credentials not received

**Check:**
- Email spam/junk folder
- Allow 3-5 business days for processing
- Follow up on the Worldwide Systems Center request ticket if no response after 5 days

**Action:**
- Reply to the original request confirmation email
- Submit a follow-up request through the Worldwide Systems Center Request Form
- Contact Worldwide Systems Center support directly via Slack

### VPN connection fails

**Common Issues:**

1. **Wrong VPN Address**
   - Ensure the address is `ssl.wsc.ihost.com`
   - Don't include `https://` or other prefixes

2. **Incorrect Credentials**
   - Verify username (case-sensitive)
   - Check for extra spaces in password
   - Ensure Caps Lock is off

3. **Network Restrictions**
   - Some corporate networks block VPN connections
   - Try from a different network (home, mobile hotspot)
   - Contact the network administrator

4. **Cisco AnyConnect Issues**
   - Update to the latest version
   - Restart the application
   - Reinstall if problems persist

### Can connect but cannot reach z/OS instances

**Verify:**
- Connection is to Worldwide Systems Center VPN (not IBM VPN)
- The z/OS instance IP address is correct
- The instance is running (not stopped or terminated)

**Try:**
- Disconnect and reconnect to VPN
- Check with platform administrators that the IP is whitelisted

---

## Security Best Practices

### Password Management

- **Change Password Regularly**: Update the Worldwide Systems Center VPN password every 90 days
- **Use Strong Passwords**: Minimum 12 characters with mixed case, numbers, symbols
- **Never Share**: VPN credentials are personal and non-transferable

### Connection Safety

- **Only Connect When Needed**: Disconnect when not actively using Worldwide Systems Center resources
- **Secure Networks**: Avoid public WiFi when connecting to VPN
- **Monitor Activity**: Report any suspicious activity to Worldwide Systems Center security

---

## Next Steps

Once working Worldwide Systems Center VPN credentials are obtained:

1. **[SSH Key Setup](./ssh-keys)** - Create SSH keypair for z/OS authentication
2. **[Provision Your First Instance](../provisioning/provision-workflow)** - Start using the platform

## Getting Help

If issues are encountered with Worldwide Systems Center VPN:

- **Worldwide Systems Center Request Issues**: Reply to the request ticket
- **Technical Problems**: Contact Worldwide Systems Center infrastructure team
- **Platform Questions**: Reach out to Jacob Emery on Slack

---

## What You've Accomplished

After completing this guide, the following are available:

✅ Worldwide Systems Center VPN credentials
✅ Cisco AnyConnect configured  
✅ Verified connectivity to Worldwide Systems Center network

One step closer to provisioning z/OS demo images!