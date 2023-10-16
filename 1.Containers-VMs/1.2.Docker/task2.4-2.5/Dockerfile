FROM python:3.6-slim

RUN pip install flask
ENV FLASK_APP="server"

COPY server.py /srv/flask_app/server.py
WORKDIR /srv/flask_app

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]

