FROM python:3.12-alpine

WORKDIR /app

# Upgrade pip and setuptools, install patched jaraco.context and remove vendored metadata that Trivy detects
RUN pip install --upgrade pip setuptools \n && pip install --no-cache-dir 'jaraco.context>=6.1.0' \n && rm -rf /usr/local/lib/python3.12/site-packages/setuptools/_vendor/jaraco.context-*.dist-info || true

# Add non-root user
RUN adduser -D myuser
USER myuser

# Copy app files (optional for this test project)
COPY --chown=myuser:myuser . .

CMD ["echo", "Hello Secure World"]