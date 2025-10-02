#!/bin/zsh
# Deploy website to S3 bucket alternic.com

echo "Generating sitemap..."
node generate-sitemap.js

echo "Uploading HTML files (short cache)..."
aws s3 sync . s3://alternic.com --delete --acl public-read \
	--exclude "*" \
	--include "*.html" \
	--cache-control "max-age=300, s-maxage=300" \
	--exclude ".git/*" \
	--exclude "node_modules/*"

echo "Uploading static assets (1 hour cache)..."
aws s3 sync . s3://alternic.com --delete --acl public-read \
	--exclude "*" \
	--include "*.css" \
	--include "*.js" \
	--include "*.png" \
	--include "*.jpg" \
	--include "*.jpeg" \
	--include "*.gif" \
	--include "*.svg" \
	--include "*.ico" \
	--include "*.woff" \
	--include "*.woff2" \
	--include "*.ttf" \
	--include "*.eot" \
	--cache-control "max-age=3600, s-maxage=3600" \
	--exclude ".git/*" \
	--exclude "node_modules/*"

echo "Uploading other files (medium cache)..."
aws s3 sync . s3://alternic.com --delete --acl public-read \
	--exclude ".git/*" \
	--exclude ".gitignore" \
	--exclude ".DS_Store" \
	--exclude "*/.DS_Store" \
	--exclude "**/.DS_Store" \
	--exclude "node_modules/*" \
	--exclude "deploy-s3.sh" \
	--exclude "package.json" \
	--exclude "package-lock.json" \
	--exclude "README.md" \
	--exclude "*.html" \
	--exclude "*.css" \
	--exclude "*.js" \
	--exclude "*.png" \
	--exclude "*.jpg" \
	--exclude "*.jpeg" \
	--exclude "*.gif" \
	--exclude "*.svg" \
	--exclude "*.ico" \
	--exclude "*.woff" \
	--exclude "*.woff2" \
	--exclude "*.ttf" \
	--exclude "*.eot" \
	--cache-control "max-age=3600, s-maxage=3600"

echo "Deployment to s3://alternic.com complete!"
