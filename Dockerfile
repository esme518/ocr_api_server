FROM python:3.8-slim-buster

COPY ./*.txt ./*.py ./*.sh ./*.onnx /app/

WORKDIR /app

RUN set -ex \
    && pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && pip list \
    && apt-get --allow-releaseinfo-change update && apt install -y \
       libgl1-mesa-glx libglib2.0-0 tini \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/*

EXPOSE 9898

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["python3","ocr_server.py","--port","9898","--ocr","--det"]
