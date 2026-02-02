# GitHub Pages Setup Instructions

This repository is now configured to automatically deploy to GitHub Pages using GitHub Actions.

## Enabling GitHub Pages

To complete the setup, you need to enable GitHub Pages in your repository settings:

1. Go to your repository on GitHub: https://github.com/RoyalKuijpers/kuijpers-assets
2. Click on **Settings** (in the repository menu)
3. In the left sidebar, click on **Pages** (under "Code and automation")
4. Under **Source**, select:
   - Source: **GitHub Actions**
5. Click **Save**

## Automatic Deployment

Once GitHub Pages is enabled, the workflow will automatically:
- Deploy on every push to the `main` or `master` branch
- Can be manually triggered from the Actions tab using "workflow_dispatch"

## Accessing Your Site

After the first successful deployment, your assets will be available at:

```
https://royalkuijpers.github.io/kuijpers-assets/
```

### Example URLs:
- Landing page: `https://royalkuijpers.github.io/kuijpers-assets/`
- Flow dashboard: `https://royalkuijpers.github.io/kuijpers-assets/KVA-QuickFlowLinker.html`
- Logo: `https://royalkuijpers.github.io/kuijpers-assets/images/logos/kuijpers-logo.png`
- QR code: `https://royalkuijpers.github.io/kuijpers-assets/images/qr-codes/QR-Pasaanvraag.png`

## Monitoring Deployments

You can monitor deployment status:
1. Go to the **Actions** tab in your repository
2. Look for "Deploy to GitHub Pages" workflow runs
3. Click on any run to see detailed logs

## Workflow Details

The workflow file is located at: `.github/workflows/deploy-pages.yml`

It uses the following actions:
- `actions/checkout@v4` - Checks out the repository
- `actions/configure-pages@v4` - Configures GitHub Pages
- `actions/upload-pages-artifact@v3` - Uploads the site content
- `actions/deploy-pages@v4` - Deploys to GitHub Pages

## Notes

- The `_config.yml` file in the root excludes certain files from being published
- All static assets (images, templates, etc.) will be served directly
- The workflow has the necessary permissions configured automatically
