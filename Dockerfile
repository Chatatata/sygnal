FROM python:2.7.15

COPY sygnal /sygnal
COPY setup.py /setup.py
COPY gunicorn_config.py /gunicorn_config.py
COPY sygnal.conf /sygnal.conf
COPY VERSION /VERSION
COPY README.rst /README.rst

RUN mkdir -p /var
RUN touch /var/access_log
RUN touch /var/error_log
RUN touch /var/sygnal.log
RUN /setup.py install --verbose
RUN pip install gunicorn
RUN rm -f /sygnal/sygnal/**.py

EXPOSE 5004

ENTRYPOINT ["/usr/local/bin/gunicorn", "--config", "/gunicorn_config.py", "-b", ":5004", "sygnal:app"]
