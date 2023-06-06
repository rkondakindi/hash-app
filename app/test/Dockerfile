FROM python:3.8-slim-buster

RUN apt-get update && apt-get upgrade -y

WORKDIR /app

# copy requirements.txt to install the required packages
COPY ./requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

COPY ./src /app/src
COPY main.py /app

CMD [ "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080" ]