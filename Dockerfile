FROM nginx:1.26.0-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY . /usr/share/nginx/html
RUN apk add git
RUN git submodule init
EXPOSE 8080
CMD [ "nginx", "-g", "daemon off;" ]
