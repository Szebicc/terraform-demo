# Use an official Node.js runtime as a parent image for building the frontend
FROM node:18 as build-stage

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy application files
COPY . .

# Build the frontend
RUN npm run build

# Debugging: List files in /app to verify that the build folder exists
RUN ls -al /app

# Use Nginx to serve the build files
FROM nginx:alpine

# Copy the build output from the previous stage (build-stage) into Nginx's HTML folder
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose the port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
