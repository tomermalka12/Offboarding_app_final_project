# Dockerfile
FROM python:3.11-slim

WORKDIR /opt/app
# install minimal deps
COPY offboarding_app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy app and script
COPY offboarding_app/ ./offboarding_app
RUN chmod +x /opt/app/offboarding_app/scripts/offboard.sh

ENV FLASK_APP=offboarding_app/main.py
EXPOSE 8080

CMD ["python", "offboarding_app/main.py"]