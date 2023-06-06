Set the base image
FROM python:3.8.1-alpine

 Set work directory
WORKDIR /src

 Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

 Copy requirements file
COPY ./requirements.txt /src/requirements.txt

 Install dependencies
RUN apk add --no-cache --virtual .build-deps \
    build-base \
    libressl-dev \
    libffi-dev \
    gcc \
    musl-dev \
    python3-dev \
    postgresql-dev \
    && pip install --upgrade pip setuptools wheel \
    && pip install -r /src/requirements.txt \
    && apk del .build-deps \
    && rm -rf /root/.cache/pip

 Copy project
COPY . /src/
