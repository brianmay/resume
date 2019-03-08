# Stage 0, to build and compile Jekyll
FROM python:3.7 as python
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"
WORKDIR /app

RUN apt-get update \
 && apt-get install -y pandoc \
 && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
 && tar vxf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
 && cp wkhtmltox/bin/wk* /usr/local/bin/

RUN pip install pipenv
ADD Pipfile Pipfile.lock /app/
RUN pipenv sync

COPY ./docs /app/docs/

RUN mkdir out \
 && pipenv run markdown-pp docs/index.mdpp -o out/brianmay.md \
 && pandoc -c style.css out/brianmay.md -o out/brianmay.pdf -t html5 \
 && pandoc -c style.css out/brianmay.md -o out/brianmay.html -t html5 \
 && pandoc -c style.css out/brianmay.md -o out/brianmay.docx -t html5

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.13
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"
COPY style.css /usr/share/nginx/html/brian/resume
COPY --from=python /app/out/ /usr/share/nginx/html/brian/resume
RUN chmod go+rX -R /usr/share/nginx/html
