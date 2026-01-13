FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:18-alpine
WORKDIR /app
RUN npm i serve@14.2.0
COPY --from=build /app/build ./build
EXPOSE 8080
CMD ["npx","serve","-s","build","-l","8080"]