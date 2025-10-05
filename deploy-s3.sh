#!/bin/zsh
#
# Example usage:
#   ./deploy-s3.sh
#
# Deploy website to S3 bucket alternic.com

echo "Generating sitemap..."
node generate-sitemap.js

echo "Uploading HTML files (short cache)..."
aws s3 sync . s3://alternic.com --delete --acl public-read \
	--exclude "*" \
	--include "*.html" \
	--include "sitemap.xml" \
	--include "robots.txt" \
	--cache-control "max-age=300, s-maxage=300" \
	--exclude ".git/*" \
	--exclude "node_modules/*"


echo "Uploading third-party vendor assets (1 year cache)..."
aws s3 sync ./js/ s3://alternic.com/js/ --delete --acl public-read \
	--exclude "*" \
	--include "jquery-3.3.1.min.js" \
	--include "jquery-migrate-3.0.1.min.js" \
	--include "bootstrap.min.js" \
	--include "popper.min.js" \
	--include "owl.carousel.min.js" \
	--include "aos.js" \
	--include "jquery.sticky.js" \
	--include "jquery.easing.1.3.js" \
	--include "jquery.fancybox.min.js" \
	--include "jquery.magnific-popup.min.js" \
	--include "jquery-ui.js" \
	--include "bootstrap-datepicker.min.js" \
	--include "stickyfill.min.js" \
	--cache-control "max-age=31536000, s-maxage=31536000, immutable" 

aws s3 sync ./css/ s3://alternic.com/css/ --delete --acl public-read \
	--exclude "*" \
	--include "bootstrap.min.css" \
	--include "bootstrap-datepicker.css" \
	--include "aos.css" \
	--include "animate.css" \
	--include "owl.carousel.min.css" \
	--include "owl.theme.default.min.css" \
	--include "jquery.fancybox.min.css" \
	--include "magnific-popup.css" \
	--include "jquery-ui.css" \
	--cache-control "max-age=31536000, s-maxage=31536000, immutable" 

echo "Uploading your static assets (1 hour cache)..."
aws s3 sync ./js/ s3://alternic.com/js/ --delete --acl public-read \
	--exclude "*" \
	--include "main.js" \
	--cache-control "max-age=3600, s-maxage=3600" 

aws s3 sync ./css/ s3://alternic.com/css/ --delete --acl public-read \
	--exclude "*" \
	--include "style.css" \
	--cache-control "max-age=3600, s-maxage=3600" 

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
