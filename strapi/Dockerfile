# Use official Node.js base image
FROM node:20

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the entire Strapi project
COPY . .

# Copy the environment variables file
# (Make sure .env is in your context and not .dockerignored)
# COPY .env .env

# Build the admin panel
RUN npm run build

# Expose port Strapi uses
EXPOSE 1337

# Start Strapi
CMD ["npm", "run", "start"]

