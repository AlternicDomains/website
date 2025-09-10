#!/bin/zsh
# Deploy website to S3 bucket alternic.com

echo "Generating sitemap..."
node generate-sitemap.js

aws s3 sync . s3://alternic.com --delete --acl public-read \
	--exclude ".git/*" \
	--exclude ".gitignore" \
	--exclude "*/.DS_Store" \
	--exclude "node_modules/*" \
	--exclude "deploy-s3.sh" \
	--exclude "package.json" \
	--exclude "package-lock.json" \
	--exclude "README.md"

echo "Deployment to s3://alternic.com complete!"
