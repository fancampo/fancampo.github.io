FROM nginx:1.26.0-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY . /usr/share/nginx/html
RUN apk add --no-cache git
RUN git clone https://github.com/panaxit/xover.git xover
EXPOSE 8080
CMD [ "nginx", "-g", "daemon off;" ]
