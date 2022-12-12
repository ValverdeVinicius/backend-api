FROM python:3.9-alpine3.13
LABEL maintainer="vinicius"

ENV PYTHONUNBUFFERED 1

COPY ./requisitos.txt /tmp/requisitos.txt
COPY ./requisitos.dev.txt /tmp/requisitos.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requisitos.txt && \
    if [ $DEV = "true" ]; \
    then /py/bin/pip install -r /tmp/requisitos.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user