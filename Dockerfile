FROM python:3.7-alpine

RUN adduser -D api

WORKDIR /home/api

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn

COPY app app
COPY api.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP api.py

RUN chown -R api:api ./
USER api

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]