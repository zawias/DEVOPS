FROM python:3
RUN mkdir /usr/src/app
ADD api /usr/src/app/api

#ENV TZ=Europe/Poland
#cd RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY *.py /usr/src/app
COPY requirements.txt /usr/src/app


