FROM python:3.11-slim-buster

COPY . /app/

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1  

RUN pip install --no-cache-dir -r requirements.txt 

EXPOSE 8080

CMD ["gunicorn", "-b", ":8080", "main.wsgi"]

