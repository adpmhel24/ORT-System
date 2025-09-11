FROM tiangolo/uvicorn-gunicorn-fastapi:python3.10-slim-2022-11-25
ENV PYTHONUNBUFFERED=1
WORKDIR /code

RUN apt-get update && apt-get install -y --no-install-recommends git  && apt install curl -y && apt-get install -y --no-install-recommends vim
COPY requirements.txt ./
ADD . /code
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install  --no-cache-dir gunicorn

ENV PYTHONPATH=/code
EXPOSE 82

