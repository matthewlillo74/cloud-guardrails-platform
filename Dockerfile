# We are using Python 2.7 (End of Life) on purpose.
# This image has HUNDREDS of known vulnerabilities.
FROM python:2.7-alpine

WORKDIR /app

# Just a dummy command so the container runs
CMD ["echo", "Hello Security"]
