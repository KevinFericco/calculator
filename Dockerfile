# build environment
FROM node:latest as build
WORKDIR /app
COPY . .
RUN yarn install
COPY . ./
RUN yarn build

# production environment
FROM node:latest
RUN yarn global add serve
WORKDIR app
COPY --from=build /app/build .
CMD ["serve", "-p", "8080","-s","/app"]
EXPOSE 8080