# Create an SSH Keypair

This guide walks through creating and managing SSH keypairs for authenticating to z/OS instance(s).

## Prerequisites

- Terminal or Command Prompt
- Basic command-line familiarity

## Why SSH Keys?

- SSH keys provide secure, password-less authentication to z/OS.
- In this environment, a public key must be provided at provisioning.
- The corresponding private key will be used for initial access to z/OS, after which the TSO/SSH password can be set.

---

## Open Terminal or Command Prompt

### macOS/Linux
- Open **Terminal** application

### Windows
- Open **Command Prompt** or **PowerShell**
- **First-time Windows users**: You may need to install [OpenSSH Client](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse)

---

## Check for Existing Keys

Before creating new keys, check if SSH keys already exist:

### macOS/Linux

```bash
ls -la ~/.ssh
```

### Windows (PowerShell)

```powershell
dir $env:USERPROFILE\.ssh
```

### What to Look For

If files like these are present:
- `id_rsa` and `id_rsa.pub`
- `id_ed25519` and `id_ed25519.pub`

SSH keys already exist and the guide can skip to [Step 4: Retrieve Your Public Key](#step-4-retrieve-your-public-key).

---

## Generate SSH Key

Execute the following command:

```bash
ssh-keygen -t rsa -b 4096
```

**Flags explained:**
- `-t rsa`: Use RSA algorithm
- `-b 4096`: Use 4096-bit key (more secure than default 2048)
- `-f ~/.ssh/keyname`: (Optional) Specify custom key name instead of default `id_rsa`

**When prompted for a passphrase:** Press **Enter** twice to skip (no passphrase required for automation)

**Default key location:**
- Private key: `~/.ssh/id_rsa`
- Public key: `~/.ssh/id_rsa.pub`

![SSH key generation](../assets/image7.png)

---

## Retrieve Your Public Key

Display the public SSH key:

### Default Key Location

```bash
cat ~/.ssh/id_rsa.pub
```

### Custom Key Location

```bash
cat ~/.ssh/wsc-zos-demo.pub
```

### Windows (PowerShell)

```powershell
type $env:USERPROFILE\.ssh\id_rsa.pub
```

---

## Step 6: Copy Your Public Key

### What It Looks Like

The public key should look like:

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDExampleKeyContent...== user@hostname
```

**Important Checks:**
- ✅ Starts with `ssh-rsa` or `ssh-ed25519`
- ✅ One long line of text
- ❌ Does NOT start with `-----BEGIN OPENSSH PRIVATE KEY-----`

### Copy to Clipboard

**macOS:**
```bash
pbcopy < ~/.ssh/id_rsa.pub
```

**Linux (with xclip):**
```bash
xclip -selection clipboard < ~/.ssh/id_rsa.pub
```

**Windows (PowerShell):**
```powershell
Get-Content $env:USERPROFILE\.ssh\id_rsa.pub | Set-Clipboard
```

**Manual Copy:**
- Select the entire output
- Copy to clipboard (Ctrl+C or Cmd+C)

### Save for Later

Keep this public key handy - it will be needed when:
- Provisioning z/OS instances in AAP
- Setting up new environments
- Configuring automation

---

## Managing Multiple Keys

If working with multiple environments, separate keys can be created for each:

### Create Environment-Specific Keys

```bash
# WSC z/OS Demo work
ssh-keygen -t rsa -b 4096 -f ~/.ssh/wsc-zos-demo -C "wsc-zos-demo"

# Other project
ssh-keygen -t rsa -b 4096 -f ~/.ssh/other-project -C "other-project"
```

### Configure SSH to Use Specific Keys

Create or edit `~/.ssh/config`:

```
# WSC z/OS instances
Host 192.168.32.*
    IdentityFile ~/.ssh/wsc-zos-demo
    User zosadmn

# Other hosts
Host other-server.com
    IdentityFile ~/.ssh/other-project
    User myuser
```

---

## Security Best Practices

### Protect Your Private Key

✅ **DO:**
- Keep private keys on the local machine only
- Set restrictive permissions: `chmod 600 ~/.ssh/id_rsa`
- Back up keys to secure, encrypted storage
- Use different keys for different purposes

❌ **DON'T:**
- Share private keys with anyone
- Store private keys in cloud storage
- Email or message private keys
- Commit private keys to version control

### Key Permissions

Ensure correct permissions on the SSH directory:

```bash
# macOS/Linux
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```

### Regular Key Rotation

- **Rotate keys annually** or when:
  - Compromise is suspected
  - Changing roles/teams
  - Leaving a project

---

## Troubleshooting

### "command not found: ssh-keygen"

**Windows:**
- Install OpenSSH Client feature
- Settings → Apps → Optional Features → Add OpenSSH Client

**macOS/Linux:**
- SSH tools should be pre-installed

### "Permission denied (publickey)"

**Check:**
- The correct private key is being used
- The public key was added to the z/OS instance
- File permissions are correct (600 for private key)

**Fix:**
```bash
# Specify key explicitly
ssh -i ~/.ssh/wsc-zos-demo zosadmn@192.168.32.10
```

### "Private key was accidentally copied"

**Identify:**
- Public key file ends in `.pub`
- Private key has no extension or ends in `.pem`
- Private keys start with `-----BEGIN`

**Action:**
- Never share private keys
- If shared accidentally, generate new keys immediately
- Update all systems with new public key

### "Bad permissions" error

**Fix permissions:**
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```

---

## Testing Your SSH Key

Once a z/OS instance is provisioned, test the key:

```bash
# Replace with the actual z/OS IP
ssh -i ~/.ssh/id_rsa zosadmn@192.168.32.10
```

**Expected result:**
- Connection succeeds without password prompt
- The z/OS welcome message appears

---

## Next Steps

Now that SSH keys are configured:

1. **[Provision Your First Instance](../provisioning/provision-workflow)** - Use the public key in AAP
2. **[Connect to z/OS](../provisioning/connecting-to-zos)** - Test SSH access
3. **[Explore Customization](../customization/overview)** - Start customizing images

## Getting Help

If SSH key issues are encountered:

- **Generation Problems**: Check the OS documentation for SSH tools
- **Permission Issues**: Review the security best practices section above
- **Connection Problems**: See the troubleshooting section
- **Platform Questions**: Contact Jacob Emery on Slack

---

## What You've Accomplished

After completing this guide, the following are available:

✅ SSH keypair generated  
✅ Public key ready for provisioning  
✅ Understanding of SSH key security  
✅ Troubleshooting knowledge  

Ready to provision z/OS instances!