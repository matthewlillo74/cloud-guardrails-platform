
FROM python:3.12-alpine

WORKDIR /app

RUN pip install --upgrade pip setuptools
# We add a non-root user for extra security (Best Practice)
RUN adduser -D myuser
USER myuser

CMD ["echo", "Hello Secure World"]
