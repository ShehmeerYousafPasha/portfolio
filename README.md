# Shehmeer Yousaf Portfolio

A Flutter Web portfolio for Shehmeer Yousaf, built with Riverpod and GoRouter.

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

## Test and build

```bash
flutter analyze
flutter test
flutter build web --release --base-href /portfolio/
```

## Deploy to GitHub Pages

The deployment workflow runs automatically when changes are pushed to `main`.

1. Create the `ShehmeerYousafPasha/portfolio` repository on GitHub.
2. Set **Settings > Pages > Source** to **GitHub Actions**.
3. Optionally add a `GA_MEASUREMENT_ID` repository secret for Analytics.
4. Push the project:

```bash
git add .
git commit -m "Initial portfolio deployment"
git push -u origin main
```

The site will be published at `https://shehmeeryousafpasha.github.io/portfolio/`.

See [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md) for deployment details.
