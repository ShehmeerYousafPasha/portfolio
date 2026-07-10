# Deploy to GitHub Pages

This project is configured as a GitHub Pages project site:

`https://shehmeeryousafpasha.github.io/portfolio/`

## One-time GitHub setup

1. Create the `ShehmeerYousafPasha/portfolio` repository on GitHub.
2. In the repository, open **Settings > Pages** and select **GitHub Actions** as the source.
3. In **Settings > Secrets and variables > Actions**, add `GA_MEASUREMENT_ID` with the real Google Analytics measurement ID. Leave it unset if Analytics is not required.
4. Configure your local Git identity if needed:

```bash
git config user.name "Your Name"
git config user.email "you@example.com"
```

## Deploy

```bash
git add .
git commit -m "Prepare GitHub Pages deployment"
git push -u origin main
```

Every push to `main` runs the deployment workflow. It installs dependencies, analyzes the project, runs tests, builds Web with `/portfolio/` as the base path, and publishes the result to GitHub Pages.

## Verify after deployment

- Open `https://shehmeeryousafpasha.github.io/portfolio/`
- Open `https://shehmeeryousafpasha.github.io/portfolio/projects` directly to verify SPA routing.
- Confirm `https://shehmeeryousafpasha.github.io/portfolio/robots.txt` and `/sitemap.xml` load.
- Verify the featured project image, resume link, social links, and contact form.
- Confirm Analytics in GA4 Realtime if `GA_MEASUREMENT_ID` was configured.

## Custom domain later

When you connect a custom domain, update the canonical and SEO URLs in `web/index.html`, `web/robots.txt`, `web/sitemap.xml`, and `lib/services/seo_service_web.dart`, then change the workflow base href from `/portfolio/` to `/`.
