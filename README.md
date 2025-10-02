# Alternic Website

## Deploying to S3

This project includes a deployment script to publish the website to the S3 bucket `alternic.com`.

### Prerequisites
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed and configured with access to the `alternic.com` S3 bucket.
- [Node.js](https://nodejs.org/) installed (for sitemap generation).

### Deployment Steps

1. Open your terminal and navigate to the project directory:
   ```
   cd /Users/user/code/alternic/website
   ```

2. Run the deploy script:
   ```
   ./deploy-s3.sh
   ```

### What the Script Does
- Generates the sitemap using `generate-sitemap.js`.
- Uploads HTML files to S3 with a short cache (5 minutes).
- Uploads static assets (CSS, JS, images, fonts) with a 1-hour cache.
- Uploads other files with a medium cache.

---

If you need help with AWS CLI setup or encounter any issues, please ask!
