# CRITICAL VULNERABILITY: Using an ancient, unsupported base image
FROM python:3.6-slim 

# CRITICAL VULNERABILITY: Running as root
USER root

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

CMD ["python", "db_connect.py"]