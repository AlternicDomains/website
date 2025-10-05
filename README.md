# Alternic Website

This is the source code of https://alternic.com website.

## Deploying to S3

This project includes a deployment script to publish the website to the S3 bucket `alternic.com`.

### Prerequisites
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed and configured with access to the `alternic.com` S3 bucket.
- [Node.js](https://nodejs.org/) installed (for sitemap generation).

### Deployment Steps

Run the deploy script:
   ```
   ./deploy-s3.sh
   ```

### What the Script Does
- Generates the sitemap using `generate-sitemap.js`.
- Uploads HTML files to S3 with a short cache (5 minutes).
- Uploads static assets (CSS, JS, images, fonts) with a 1-hour cache.
- Uploads other files with a medium cache.

---

## Contributing & Contact

Contributions are welcome. To get in touch:

- Telegram: https://t.me/alternic
- X (Twitter): https://x.com/alternic