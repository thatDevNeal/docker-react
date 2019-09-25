# Multi-Stage
# first build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# nginx, content to serve static html
# /usr/share/nginx/html --> where nginx wants you to put it
# don't need to run anything to start up nginx
# when starting up that container, it'll handle starting up itself.

# open up port when running this, "docker run -pp 8080:80 ..."
