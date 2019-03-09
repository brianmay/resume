# Stage 0, to build and compile Jekyll
FROM python:3.7 as python
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"
WORKDIR /app

RUN apt-get update \
 && apt-get install -y pandoc xfonts-75dpi xfonts-base \
 && rm -rf /var/lib/apt/lists/*

ENV WKHTML2PDF_VERSION 0.12.5
RUN wget "https://downloads.wkhtmltopdf.org/0.12/${WKHTML2PDF_VERSION}/wkhtmltox_${WKHTML2PDF_VERSION}-1.stretch_amd64.deb" \
 && apt-get install -y ./wkhtmltox_${WKHTML2PDF_VERSION}-1.stretch_amd64.deb

RUN pip install pipenv
ADD Pipfile Pipfile.lock /app/
RUN pipenv sync

COPY style.css /app/
COPY ./fonts /app/fonts/
COPY ./docs /app/docs/

# version info
ARG BUILD_DATE=date
ARG VCS_REF=commit

RUN mkdir out \
 && echo "Document version: ${BUILD_DATE} ${VCS_REF}" > docs/version.mdpp \
 && pipenv run markdown-pp docs/index.mdpp -o out/brianmay.md \
 && pandoc -c style.css out/brianmay.md -o out/brianmay.pdf -t html5 \
 && pandoc -c style.css out/brianmay.md -o out/brianmay.html -t html5 \
 && pandoc -c style.css out/brianmay.md -o out/brianmay.docx -t html5

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.13
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"
RUN mkdir -p /usr/share/nginx/html/brian/resume
COPY style.css /usr/share/nginx/html/brian/resume/
COPY fonts /usr/share/nginx/html/brian/resume/fonts/
COPY --from=python /app/out/ /usr/share/nginx/html/brian/resume
RUN chmod go+rX -R /usr/share/nginx/html
