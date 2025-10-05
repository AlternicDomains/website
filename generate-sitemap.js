const { SitemapStream, streamToPromise } = require('sitemap');
const { createWriteStream, readFileSync } = require('fs');
const xmlFormatter = require('xml-formatter');

const sitemap = new SitemapStream({ hostname: 'https://alternic.com/' });

const now = new Date().toISOString(); // YYYY-MM-DDTHH:mm:ss.sssZ

sitemap.write({ url: '/', changefreq: 'daily', priority: 1.0, lastmod: now });
sitemap.write({ url: '/contact.html', changefreq: 'monthly', priority: 0.8, lastmod: now });
sitemap.write({ url: '/custody-domain.html', changefreq: 'monthly', priority: 0.8, lastmod: now });
sitemap.write({ url: '/tokenisation-domain.html', changefreq: 'monthly', priority: 0.8, lastmod: now });
sitemap.write({ url: '/terms.html', changefreq: 'monthly', priority: 0.7, lastmod: now });
// Add dynamic buy-domain URLs from buy-domains.txt
try {
  const domains = readFileSync('./buy-domains.txt', 'utf-8')
    .split('\n')
    .map(line => line.trim())
    .filter(Boolean);
  domains.forEach(domain => {
    sitemap.write({
      url: `/buy-domain/${domain}`,
      changefreq: 'monthly',
      priority: 0.6,
      lastmod: now
    });
  });
} catch (e) {
  console.warn('Could not read buy-domains.txt:', e.message);
}

sitemap.end();

streamToPromise(sitemap).then(sm => {
  const formatted = xmlFormatter(sm.toString(), { collapseContent: true });
  createWriteStream('./sitemap.xml').write(formatted);
});
