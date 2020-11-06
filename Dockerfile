# build environment
FROM node:latest as build
WORKDIR /app
COPY . .
RUN yarn install
COPY . ./
RUN yarn build

# production environment
FROM nginx:stable-alpine
RUN yarn global add serve
WORKDIR app
COPY --from=build /app/build .
CMD ["serve", "-p", "8080","-s","."]
EXPOSE 8080