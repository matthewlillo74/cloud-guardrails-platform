# Upgrade to Python 3.9 (Alpine version is tiny and secure)
FROM python:3.9-alpine

WORKDIR /app

RUN pip install --upgrade pip setuptools
# We add a non-root user for extra security (Best Practice)
RUN adduser -D myuser
USER myuser

CMD ["echo", "Hello Secure World"]
