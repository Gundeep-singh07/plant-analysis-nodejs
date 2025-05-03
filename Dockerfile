FROM node:18-alpine

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Create reports directory
RUN mkdir -p reports

# Create upload directory
RUN mkdir -p upload

# Expose the port your app runs on
EXPOSE 3004

# Start the application
CMD ["node", "app.js"]