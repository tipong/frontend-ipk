# Gunakan image node untuk build
FROM node:18 AS build-stage


# Tentukan working directory
WORKDIR /app

# Salin package.json dan package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Salin semua file dari project ke container
COPY . .

# Build project Vue.js untuk production
RUN npm run build

# Gunakan image Nginx untuk serve hasil build
FROM nginx:alpine

# Salin build hasil Vue ke dalam Nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose port untuk server Nginx
EXPOSE 80

# Jalankan Nginx di port 80
CMD ["nginx", "-g", "daemon off;"]
