# GitHub Pages Deployment Guide

This guide walks through deploying the documentation to GitHub Pages.

## Prerequisites

1. **GitHub Repository**: Your docs must be in a GitHub repository (github.com or github.ibm.com)
2. **Node.js**: Version 20 or higher installed locally
3. **Repository Access**: Admin or write access to enable GitHub Pages

## Important: Fix Package Dependency First

Your `package.json` currently has a local file path dependency that won't work in GitHub Actions:

```json
"@c360/beamz-docs": "file:/Users/jemery/Documents/workdir/git/beamz/beamz-docs"
```

**You need to change this to one of:**

### Option A: Use Artifactory (if available)
```json
"@c360/beamz-docs": "1.1.13"
```

### Option B: Use Git URL
```json
"@c360/beamz-docs": "git+https://github.ibm.com/zcomm/beamz-docs.git"
```

### Option C: Use Git URL with specific version/tag
```json
"@c360/beamz-docs": "git+https://github.ibm.com/zcomm/beamz-docs.git#v1.1.13"
```

## Deployment Steps

### Step 1: Update package.json Dependency

1. Open `beamz-zos-demo-docs/package.json`
2. Change the `@c360/beamz-docs` dependency to use Artifactory or Git URL (see above)
3. Run `npm install` to update `package-lock.json`
4. Commit both files:
   ```bash
   cd beamz-zos-demo-docs
   git add package.json package-lock.json
   git commit -m "Fix beamz-docs dependency for CI/CD"
   ```

### Step 2: Enable GitHub Pages in Repository Settings

1. Go to your repository on GitHub
2. Click **Settings** → **Pages** (in left sidebar)
3. Under **Source**, select **GitHub Actions**
4. Click **Save**

### Step 3: Push the GitHub Actions Workflow

The workflow file has been created at `.github/workflows/deploy-gh-pages.yml`. Now push it:

```bash
cd beamz-zos-demo-docs
git add .github/workflows/deploy-gh-pages.yml
git commit -m "Add GitHub Pages deployment workflow"
git push origin main  # or 'master' depending on your branch
```

### Step 4: Monitor the Deployment

1. Go to your repository on GitHub
2. Click the **Actions** tab
3. You should see the "Deploy to GitHub Pages" workflow running
4. Wait for it to complete (usually 2-5 minutes)

### Step 5: Access Your Documentation

Once deployed, your docs will be available at:

**For github.com:**
```
https://<username>.github.io/<repo-name>/docs
```

**For github.ibm.com:**
```
https://pages.github.ibm.com/<org>/<repo-name>/docs
```

The `/docs` path comes from your `basePath` setting in `docs.config.json`.

## Building Different Versions

### Internal Version (Default)
The workflow is currently set to build the **internal version** with all content:
```yaml
run: npm run build
```

### Public Version
To deploy the **public version** (strips internal-only content), change line 30 in the workflow to:
```yaml
run: npm run build:public
```

## Troubleshooting

### Build Fails: "Cannot find module '@c360/beamz-docs'"

**Problem**: The local file path dependency doesn't work in GitHub Actions.

**Solution**: Update `package.json` to use Artifactory or Git URL (see Step 1 above).

### Build Fails: Authentication Required for Artifactory

**Problem**: GitHub Actions can't access IBM's internal Artifactory.

**Solution**: Use the Git URL option instead:
```json
"@c360/beamz-docs": "git+https://github.ibm.com/zcomm/beamz-docs.git"
```

You may need to add a GitHub token for private repos. Add this to the workflow before `npm ci`:

```yaml
- name: Configure Git for private repos
  run: |
    git config --global url."https://${{ secrets.GITHUB_TOKEN }}@github.ibm.com/".insteadOf "https://github.ibm.com/"
```

### 404 Error When Accessing Site

**Problem**: The site loads but shows 404 for all pages.

**Solution**: Check your `basePath` in `docs.config.json`. It should match your repository structure:
- For `https://username.github.io/repo-name/docs` → `"basePath": "/docs"`
- For `https://username.github.io/docs` → `"basePath": "/docs"`

### Images Not Loading

**Problem**: Images show broken links.

**Solution**: Ensure images are in `assets` folders next to your markdown files and use relative paths:
```markdown
![Diagram](./assets/diagram.png)
```

## Manual Deployment (Alternative)

If you prefer to deploy manually without GitHub Actions:

### 1. Build Locally
```bash
cd beamz-zos-demo-docs
npm install
npm run build  # or npm run build:public
```

### 2. Deploy to gh-pages Branch
```bash
# Install gh-pages package
npm install -D gh-pages

# Add deploy script to package.json
# "deploy": "gh-pages -d .docs-engine/out"

# Deploy
npm run deploy
```

### 3. Configure GitHub Pages
- Go to Settings → Pages
- Set Source to **Deploy from a branch**
- Select **gh-pages** branch
- Click Save

## Next Steps

After successful deployment:

1. **Test the site**: Visit your GitHub Pages URL and verify all pages load
2. **Check internal/public content**: Verify internal-only sections are visible/hidden as expected
3. **Test search**: Try the Cmd+K / Ctrl+K search functionality
4. **Verify images**: Check that all images and diagrams render correctly
5. **Test navigation**: Click through the sidebar to ensure all links work

## Updating Documentation

After the initial deployment, any push to your main branch will automatically trigger a rebuild and redeploy. The process is:

1. Edit markdown files locally
2. Test with `npm run preview`
3. Commit and push changes
4. GitHub Actions automatically rebuilds and deploys

## Questions?

- Check the Actions tab for build logs if deployment fails
- Verify your `docs.config.json` settings match your repository structure
- Ensure all markdown files referenced in navigation actually exist