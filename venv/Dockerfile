
FROM python:2.7
RUN apt update
RUN apt install git -y
RUN apt install python3 -y
RUN apt install python3-pip -y
RUN apt install python3-wheel
RUN pip3 install boto3 --user
WORKDIR /app
COPY requirements.txt .
RUN pip3 install -r requirements.txt
COPY . .
ENTRYPOINT ["/usr/bin/python3", "run.py"]