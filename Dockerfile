FROM python:3.9-slim
WORKDIR /app
COPY ./requirements.txt /app
RUN pip install flask
COPY app.py data.txt config.ini .
EXPOSE 8080
ENV VAR1="Value from Dockerfile"
CMD ["python3", "/app/app.py"]
