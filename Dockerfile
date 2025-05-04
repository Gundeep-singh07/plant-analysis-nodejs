FROM --platform=linux/amd64 node:18-alpine

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Create reports and upload directories
RUN mkdir -p reports
RUN mkdir -p upload

# Add health check endpoint for ECS
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3004/health || exit 1

# Expose the port your app runs on
EXPOSE 3004

# Start the application
CMD ["node", "app.js"]