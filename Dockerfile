# Stage 0, to build and compile Jekyll
FROM python:3.7-buster as python
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"
WORKDIR /app

RUN apt-get update \
 && apt-get install -y pandoc xfonts-75dpi xfonts-base \
 && rm -rf /var/lib/apt/lists/*

ENV WKHTML2PDF_VERSION 0.12.6
RUN wget "https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_${WKHTML2PDF_VERSION}-1.buster_amd64.deb" \
 && apt-get install -y ./wkhtmltox_${WKHTML2PDF_VERSION}-1.buster_amd64.deb

RUN pip install pipenv
ADD Pipfile Pipfile.lock /app/
RUN pipenv sync

COPY build style.css /app/
COPY ./fonts /app/fonts/
COPY ./docs /app/docs/

# version info
ARG GITHUB_SHA
ARG GITHUB_REF
ENV SHA=$GITHUB_SHA
ENV REF=$GITHUB_REF

RUN mkdir out \
 && echo "Document version: ${VCS_REF} ${BUILD_DATE}" > docs/version.mdpp \
 && ./build

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.13
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"
RUN mkdir -p /usr/share/nginx/html/brian/resume
COPY --from=python /app/out/ /usr/share/nginx/html/brian/resume
RUN chmod go+rX -R /usr/share/nginx/html
