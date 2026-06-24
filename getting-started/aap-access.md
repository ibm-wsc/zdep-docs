# Get CIO Ansible Access

This guide walks through requesting access to CIO Ansible Automation Platform (AAP), which is where the z/OS provisioning and configuration automation lives.

## Prerequisites

- IBM intranet ID
- Access to IBM's internal network (VPN)
- Valid business justification for creating demo images

## Overview

Access is requested through AccessHub, which involves:
1. Submitting an access request
2. Manager approval
3. Bluegroup owner approval
4. Verification of access

**Time Required**: 1-3 business days (depending on approval speed)

---

## Navigate to AccessHub

Go to [AccessHub](https://ibm.biz/accesshub) and sign in with IBM credentials.

## Start an Access Request

1. Click on **"Start an Access Request"** at the top
2. Select **"Application"** in the pop-up window

![AccessHub start request](../assets/image1.png)

## Search for CIO Ansible

1. In the search bar on the left, enter **"CIO Ansible"**
2. Click the search icon
3. Select the **"CIO Ansible"** application from the results
4. Click **Next**

![Search for CIO Ansible](../assets/image2.png)

## Select the Required Entitlement

1. Under "Available Entitlements" on the left side, search for:
   ```
   cio-tower_Zeco-1090_members
   ```
2. Click **"+ADD"** next to the entitlement
3. Click **Next**

![Select entitlement](../assets/image3.png)

## Provide Justification

Enter a justification for the request. Example:

```
As a member of the IBM Z Ecosystem team, I require access to CIO Ansible
Automation Platform to provision z/OS in order to build out a _____________ demo image for
IBM technical sales enablement and TechZone publishing.
```

Click **Submit Request**.

![Provide justification](../assets/image4.png)

## Wait for Approval

1. The first line manager will receive an approval request
2. After manager approval, the bluegroup owner will receive a request
3. Once the "Entitlement Owner Task" is approved, the request will be marked **"Complete"**

Request status can be checked anytime by clicking **"Request History"** on the AccessHub home page.

![Request approval status](../assets/image5.png)

## Verify Access

Once approved, AccessHub will add the intranet ID to the specified bluegroup (typically within one hour).

Membership can be verified at the [bluegroup page](https://w3.ibm.com/tools/groups/protect/groupsgui.wss).

---

## Troubleshooting

### My AccessHub request is taking too long

- Check the "Request History" to see which approval step is pending
- Contact the manager if the request is stuck at their approval
- Reach out to the bluegroup owner if stuck at the entitlement owner approval

### I can't find the CIO Ansible application

- Ensure the search is in the "Application" category, not "Role" or "Group"
- Try searching for just "Ansible" if "CIO Ansible" doesn't return results

### My request was denied

- Review the denial reason in AccessHub
- Ensure the justification clearly explains the need for demo image creation
- Resubmit with additional context if needed

---

## Next Steps

Once AAP access is obtained, continue with:

1. **[Request a WSC VPN ID](./wsc-vpn-setup)** - Get VPN credentials for accessing z/OS instances
2. **[Create an SSH Keypair](./ssh-keys)** - Create SSH keypair for authentication

## Getting Help

If issues are encountered with AccessHub:
- Contact the manager for approval-related questions
- Contact the bluegroup owner for entitlement issues
- Reach out to Jacob Emery on Slack for platform-specific questions