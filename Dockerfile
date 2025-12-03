# Basis OS
FROM python:3.12-slim

#Work directory
WORKDIR /app

#Require coppy
COPY requirements.txt .

#install
RUN pip install -r requirements.txt

#copy der Rest
COPY . .

#Start
CMD ["python", "app.py"]

