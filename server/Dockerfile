# Starting from a node base image
FROM node:18-alpine as builder

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install


# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 5000

# Command to run the app
CMD [ "node", "app.js" ]

FROM mongo:latest

# Exposez le port MongoDB par défaut
EXPOSE 27017

# Copiez les artefacts de l'étape précédente dans cette étape
COPY --from=builder /usr/src/app /usr/src/app

# Démarrez le service MongoDB au lancement du conteneur
CMD ["mongod"]