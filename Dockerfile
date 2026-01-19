FROM python:3.12-alpine

WORKDIR /app

# Upgrade pip and setuptools, then ensure a patched jaraco.context is installed
RUN pip install --upgrade pip setuptools \
 && pip install --no-cache-dir 'jaraco.context>=6.1.0'

# We add a non-root user for extra security (Best Practice)
RUN adduser -D myuser
USER myuser

# Copy app files (optional for this test project)
COPY --chown=myuser:myuser . .

CMD ["echo", "Hello Secure World"]