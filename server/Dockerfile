# Etape 1: Construire l'application Node.js
FROM node:18-alpine 

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 5000

CMD ["node", "app.js"]


FROM mongo:latest

EXPOSE 27017

CMD ["mongod"]
