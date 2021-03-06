FROM tiangolo/node-frontend:10 as build-stage
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY ./ /app/
RUN npm run build
# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx

FROM nginx
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
#COPY ./build /var/www
COPY --from=build-stage /app/build/ /var/www
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]