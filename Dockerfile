# Dockerfile
FROM python:3.12-slim

# Set the working directory
WORKDIR /opt/app

# install minimal dependencies
RUN apt-get update && apt-get install -y 
COPY offboarding_app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy app and script
COPY offboarding_app/ ./offboarding_app
RUN chmod +x /opt/app/offboarding_app/scripts/initial_script01.sh

ENV FLASK_APP=offboarding_app/app.py
EXPOSE 8080

CMD ["python", "offboarding_app/app.py"]
