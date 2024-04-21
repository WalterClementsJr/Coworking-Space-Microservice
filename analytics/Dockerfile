FROM python:3.10-slim-buster

WORKDIR /app

COPY . .

RUN ls

RUN pip install -r requirements.txt

ENTRYPOINT ["python", "app.py"]
