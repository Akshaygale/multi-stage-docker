# ---- Stage 1: Build React App ----
FROM node:16-alpine AS build
WORKDIR /app

# Copy package.json first to optimize Docker caching
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the project files
COPY . .
RUN npm run build




# ---- Stage 2: Serve with Nginx ----
FROM nginx:alpine
WORKDIR /usr/share/nginx/html

# Copy built React files from build stage
COPY --from=build /app/build .

# Expose port 80 (default for Nginx)
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

