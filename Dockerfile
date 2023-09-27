# build phase
FROM node:18-alpine as builder

WORKDIR /app

COPY package.json .
COPY package-lock.json .

RUN npm install

COPY . .

RUN npm run build

# run phase
FROM nginx:1.25.2-alpine

COPY --from=builder /app/build /usr/share/nginx/html