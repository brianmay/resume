# Stage 0, to build and compile Jekyll
FROM python:3.7-buster as python
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

COPY build style.css /app/
COPY ./fonts /app/fonts/
COPY ./docs /app/docs/

# version info
ARG GITHUB_SHA
ARG GITHUB_REF
ENV SHA=$GITHUB_SHA
ENV REF=$GITHUB_REF

RUN mkdir out \
 && echo "Document version: ${SHA} ${REF}" > docs/version.mdpp \
 && ./build

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.13
LABEL maintainer="Brian May <brian@linuxpenguins.xyz>"
RUN mkdir -p /usr/share/nginx/html/brian/resume
COPY --from=python /app/out/ /usr/share/nginx/html/brian/resume
RUN chmod go+rX -R /usr/share/nginx/html
