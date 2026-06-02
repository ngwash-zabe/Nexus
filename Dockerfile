# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Production stage
FROM node:18-alpine

WORKDIR /app

# Install simple HTTP server
RUN npm install -g http-server

COPY --from=builder /app/dist ./dist

EXPOSE ${PORT:-5173}

CMD ["http-server", "dist", "-p", "${PORT:-5173}", "--cors"]