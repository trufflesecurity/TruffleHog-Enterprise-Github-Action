# [TruffleHog Enterprise](https://trufflesecurity.com/) GitHub Action

[![License](https://img.shields.io/github/license/trufflesecurity/Trufflehog-Enterprise-Github-Action?color=green&style=for-the-badge)](LICENSE)

Find exposed credentials in your CI using [**TruffleHog Enterprise**](https://trufflesecurity.com/).

## Requirements

- You must have a TruffleHog Enterprise instance. You can [inquire](https://trufflesecurity.com/contact) to obtain one.
- You must have added a new scanner group to use with CI.

### Project secrets

Three environment variables are required to run TruffleHog Enterprise:

```bash
TRUFFLEHOG_API_ADDRESS
TRUFFLEHOG_SCANNER_GROUP
TRUFFLEHOG_SCANNER_TOKEN
```

The values for these variables can be obtained from the downloaded configuration when you add a new scanner group on your instance.

Alternatively, these values can be provided by [other means](https://docs.trufflesecurity.com/docs/configuration/secrets-management/).

## Usage

Add a new job to your GitHub workflow using the `trufflesecurity/TruffleHog-Enterprise-Github-Action` action.

```yaml
name: TruffleHog Enterprise scan

on: [push, pull_request]

jobs:
  scanning:
    name: TruffleHog Enterprise scan
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          fetch-depth: 0 # fetch all history so multiple commits can be scanned
      - name: TruffleHog Enterprise scan
        uses: trufflesecurity/TruffleHog-Enterprise-Github-Action@main
        with:
            args: --fail-verified ${{ github.event.repository.default_branch }} HEAD
        env:
          TRUFFLEHOG_API_ADDRESS: ${{ secrets.TRUFFLEHOG_API_ADDRESS }}
          TRUFFLEHOG_SCANNER_GROUP: ${{ secrets.TRUFFLEHOG_SCANNER_GROUP }}
          TRUFFLEHOG_SCANNER_TOKEN: ${{ secrets.TRUFFLEHOG_SCANNER_TOKEN }}
```

Be sure to set the repository or organization secrets on GitHub with the variables that are referenced above.

### Extra scanner options

The following options can be added to the action by adding them to the args list.

```bash
Flags:
      --help                  Show context-sensitive help (also try --help-long and --help-man).
  -v, --debug                 Enable debug mode.
      --trace                 Enable tracing of code line numbers.
      --json                  Enable JSON output.
      --send-error-telemetry  Turns error telemetry off.
      --fail-verified         Only emit failure code for verified findings.
      --quiet                 Only show results.
      --config=CONFIG         Path to configuration file. You can also specify Google Secrets Manager secrets with
                              'gsm://<project_id>/<secret_name>'.

Args:
  <base>       Start scanning from here (usually main branch).
  <head>       Scan commits until here (usually dev branch).
  [<workdir>]  Optional path to the repo to scan.
```
