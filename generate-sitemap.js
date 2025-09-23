const { SitemapStream, streamToPromise } = require('sitemap');
const { createWriteStream } = require('fs');

const sitemap = new SitemapStream({ hostname: 'https://alternic.com/' });

sitemap.write({ url: '/', changefreq: 'daily', priority: 1.0 });
sitemap.write({ url: '/index.html', changefreq: 'daily', priority: 1.0 });
sitemap.write({ url: '/contact.html', changefreq: 'monthly', priority: 0.8 });
sitemap.write({ url: '/custody-domain.html', changefreq: 'monthly', priority: 0.8 });
sitemap.write({ url: '/tokenisation-domain.html', changefreq: 'monthly', priority: 0.8 });
// Add more pages as needed
sitemap.end();

streamToPromise(sitemap).then(sm => {
  createWriteStream('./sitemap.xml').write(sm.toString());
});
