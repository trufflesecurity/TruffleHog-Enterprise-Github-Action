FROM us-docker.pkg.dev/thog-artifacts/public/scanner-launcher
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]