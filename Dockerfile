FROM us-docker.pkg.dev/thog-artifacts/public/scanner
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]