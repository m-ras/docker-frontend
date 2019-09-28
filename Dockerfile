# Multi-step build process so we do not copy the source code into the final image

# Build phase - installs dependencies and builds the application
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . . 
RUN npm run build

# Run phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# Default nginx container runs, no need to overwrite it with CMD