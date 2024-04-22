FROM public.ecr.aws/docker/library/python:3.10-slim-buster

WORKDIR /app
COPY . .
RUN pip install -r requirements.txt

ENTRYPOINT ["python", "app.py"]
