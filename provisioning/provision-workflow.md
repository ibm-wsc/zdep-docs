# Provision z/OS Workflow

This guide walks through provisioning a z/OS instance using the Ansible Automation Platform (AAP). The entire process takes approximately 1 hour from start to finish.

## Prerequisites

Before beginning, ensure the following are available:

- ✅ Access to CIO Ansible Automation Platform
- ✅ WSC VPN ID and credentials
- ✅ SSH public key (from onboarding)
- ✅ Connected to IBM network via Cisco AnyConnect VPN (e.g., AMERICA-FAST)

If these steps haven't been completed, see the [Onboarding Guide](../getting-started/onboarding).

---

## Step 1: Access Ansible Automation Platform

### 1.1 Navigate to AAP

Go to [CIO Ansible Automation Platform](https://ansible.cio.ibm.com).

### 1.2 Sign In

The system may automatically prompt to sign in with w3id, or a login screen may appear. Click the profile icon to initiate w3 sign-on.

![AAP login screen](../../getting-started/assets/image8.png)

### Troubleshooting Sign-On

**Authentication Redirect Delay**
- There may be a delay during "Authentication Redirect"
- This is a known issue - please wait up to 1 minute

**"Page has expired" Error**
- Click the "Restart" link to restart the login process

**"Unexpected error when authenticating" Error**
- Refresh the browser page and try again

---

## Step 2: Launch the Provision z/OS Template

### 2.1 Navigate to Templates

1. Click on the **"Templates"** tab under **"Resources"** in the left-hand toolbar
2. Search for or find **"Provision z/OS"** in the list
3. Click the rocket button (🚀) labeled **"Launch Template"**

![Navigate to templates](../../getting-started/assets/image9.png)

![Launch Provision z/OS template](../../getting-started/assets/image10.png)

---

## Step 3: Fill Out the Survey

A survey form will be presented to configure the z/OS instance. Use the question mark (?) buttons next to each field for detailed guidance.

![Survey form](../../getting-started/assets/image11.png)

![Survey help tooltips](../../getting-started/assets/image12.png)

### Required Fields

| Field | Description | Example |
|-------|-------------|---------|
| **Instance Name** | Unique identifier for the instance | `jemery-cics-demo-001` |
| **z/OS Image** | Base z/OS image to deploy | `zos-v3r1-lte1-latest` |
| **z/OS Middleware** | Middleware to include (JSON array) | `["cics62"]` |
| **zADE Size** | Instance size (small/medium/large) | `medium` |
| **z/OS Admin SSH Public Key** | SSH public key from onboarding | `ssh-rsa AAAAB3...` |
| **Guest Network** | The project's guest network | `project-network-name` |
| **Service Network** | Shared zADE service network | `zade-service-network` |

### Optional Fields

| Field | Description | Default |
|-------|-------------|---------|
| **z/OS IP Address** | Static IP for z/OS (if desired) | Auto-assigned |
| **z/OS Networking Type** | `tap` or `tunnel` | `tap` |
| **z/OS User Volume Size** | Size in GB for user volume | `50` |
| **Service Admin Password Hash** | Hashed password for service admin | Auto-generated |

### Middleware Selection

The **z/OS Middleware** field accepts a JSON array. Examples:

```json
["cics62"]                           # CICS only
["cics62", "db2v13"]                 # CICS and Db2
["cics62", "db2v13", "ims156"]       # Multiple middleware
["all"]                              # All available middleware
["none"]                             # No middleware (base z/OS only)
[]                                   # No middleware (empty array)
```

**Available Middleware Options:**
- `cics62` - CICS Transaction Server 6.2
- `db2v13` - Db2 for z/OS v13
- `ims156` - IMS 15.6
- `mqcd94` - MQ for z/OS 9.4
- `iws102` - IBM Workload Scheduler 10.2

---

## Step 4: Review and Submit

### 4.1 Review Your Configuration

1. Click the blue **Next** button at the bottom of the survey
2. Review all inputs to ensure they're correct
3. Click the blue **Finish** button to start provisioning

![Review survey inputs](../../getting-started/assets/image13.png)

### 4.2 Monitor Workflow Progress

The workflow will take approximately **1 hour** to complete. A workflow visualizer will show the progress.

**Tip**: Use the magnifier (+) button in the bottom left to zoom in and see what's happening.

![Workflow visualizer](../../getting-started/assets/image14.png)

### 4.3 Workflow Stages

The provisioning workflow includes these major stages:

1. **Validate Inputs** - Verify configuration and middleware choices
2. **Create Infrastructure** - Provision OpenStack resources
3. **Setup Linux Host** - Configure the zADE server
4. **Prepare Storage** - Create and attach volumes
5. **Download z/OS Image** - Pull image from Cloud Object Storage
6. **Configure z/OS** - Set up networking and device mapping
7. **Start z/OS** - Boot the z/OS guest
8. **Middleware Configuration** - Install and configure selected middleware (if any)

### 4.4 Troubleshooting Workflow Failures

If the workflow fails:

1. Note which stage failed (visible in the workflow visualizer)
2. Click on the failed node to see error details
3. Contact Jacob Emery on Slack with:
   - Link to the workflow visualizer page
   - Screenshot of the error
   - The instance name

---

## Step 5: Retrieve Your z/OS IP Address

### 5.1 Navigate to the Final Node

Once the workflow completes successfully:

1. Click on the last node: **"Print z/OS IP"**
2. You can access this either from:
   - The workflow visualizer, or
   - The **Jobs** tab in the left-hand toolbar

### 5.2 Find Your IP Addresses

**Option A: Via Details Tab**
1. Click on **'Details'**
2. Scroll down to the **'Artifacts'** section
3. You'll see both:
   - **z/OS Guest IP**: For connecting to z/OS
   - **Linux Host IP**: For troubleshooting (if needed)

![IP addresses in artifacts](../../getting-started/assets/image15.png)

**Option B: Via Output**
1. Scroll to the bottom of the output
2. Look for the IP addresses in the final output messages

**Example Output:**
```
z/OS IP: 192.168.32.16
Linux Host IP: 192.168.32.15
```

**Important**: Save these IP addresses - they will be needed to connect to the instance!

---

## Step 6: Connect to Your z/OS Instance

Now that the instance is provisioned, connection can be established. See the [Connecting to z/OS](../using-images/connecting) guide for detailed instructions.

### Quick Connection Test

1. Connect to WSC VPN using the WSC VPN credentials:
   ```
   Server: ssl.wsc.ihost.com
   ```

2. SSH to the z/OS instance:
   ```bash
   ssh zosadmn@192.168.32.16 -i ~/.ssh/id_rsa
   ```

3. If successful, the z/OS welcome screen will appear!

---

## Optional: Using the EVA Slack Bot

z/OS instances can also be provisioned using the EVA Slack bot. This is useful for quick provisioning without opening the AAP web interface.

### 1. Start a Conversation with EVA

In Slack, start a new message with the **EVA** app.

![Start EVA conversation](../../getting-started/assets/image16.png)

### 2. Initiate Workflow

Type and send:
```
/workflow-job-template
```

![EVA workflow command](../../getting-started/assets/image17.png)

### 3. Select Template

1. In the dialog box, type: `Provision z/OS`
2. Click the **'Create'** button

![Select Provision z/OS template](../../getting-started/assets/image18.png)

### 4. Fill Out Form

1. Click **"Fill workflow job template info"**
2. Fill out the same survey fields as in the AAP web interface
3. Click **'Run'**

![Fill out EVA form](../../getting-started/assets/image19.png)

### 5. Monitor Progress

1. Click the link to the created job to open it in AAP
2. If prompted to authenticate, click the link again after signing in
3. Click the **'Output'** tab to see the workflow visualizer

![EVA job link](../../getting-started/assets/image20.png)

---

## What's Next?

After provisioning the z/OS instance:

1. **[Connect to Your Instance](../using-images/connecting)** - Set up TSO access and test connectivity
2. **[Customize Your Image](../customization/overview)** - Add demo content and configurations
3. **[Create a Snapshot](../snapshot/creating-snapshots)** - Capture the customized image
4. **[Publish to TechZone](../snapshot/publishing-techzone)** - Make it available for technical sales

---

## Instance Management

Once the instance is running, available operations include:

- **[Reboot](../provisioning/instance-management#rebooting)** - Restart the z/OS instance
- **[Recreate](../provisioning/instance-management#recreating)** - Rebuild with a different configuration
- **[Teardown](../provisioning/instance-management#teardown)** - Delete the instance

See the [Instance Management](../provisioning/instance-management) guide for details.

---

## Frequently Asked Questions

### How long does provisioning take?
Approximately 1 hour for a complete z/OS instance with middleware.

### Can I provision multiple instances?
Yes, but each instance must have a unique **Instance Name**.

### What if I need a different z/OS version?
Specify a different **z/OS Image** in the survey (e.g., `zos-v3r2-lte1-latest`).

### Can I change middleware after provisioning?
Yes, use the **Recreate** workflow to rebuild with different middleware selections.

### What if the z/OS IP is forgotten?
Use the **"What's my IP again?"** workflow template in AAP to retrieve it.

### Can data be kept between recreates?
Yes! Select **"Keep z/OS User Volume"** in the Teardown workflow, then use the same **Instance Name** when recreating.

---

## Troubleshooting

### AAP is slow or unresponsive
- The CIO AAP runs thousands of jobs daily and can be slow at times
- Try refreshing the page
- Check the `#cio-ansible` Slack channel for outage announcements

### Cannot SSH to z/OS after provisioning
- Ensure connection to the WSC VPN (`ssl.wsc.ihost.com`)
- Verify the correct IP address from the workflow output is being used
- Check that the correct SSH private key is being used

### Workflow failed during middleware configuration
- Check if the middleware choice is valid
- Ensure the z/OS image supports the selected middleware
- Contact support with the workflow link and error details

---

## Getting Help

- **Platform Issues**: Contact Jacob Emery on Slack
- **AAP General Issues**: Check `#cio-ansible` Slack channel
- **Access Issues**: See the [Onboarding Guide](../getting-started/onboarding)