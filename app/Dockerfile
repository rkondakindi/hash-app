FROM python:3.9-alpine

# RUN apt-get update && apt-get upgrade -y

WORKDIR /app

RUN addgroup -g 1001 orion \
    && adduser -u 1001 -G orion -D --shell /bin/nologin orion

# copy requirements.txt to install the required packages
COPY ./requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

COPY ./src /app/src
COPY main.py /app

USER orion
CMD [ "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080" ]