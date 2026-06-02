FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Production stage
FROM node:18-alpine

WORKDIR /app

# Install http-server
RUN npm install -g http-server

COPY --from=builder /app/dist ./dist

# Listen on all interfaces
EXPOSE 3000

# Use sh -c to expand environment variables properly
CMD ["sh", "-c", "http-server dist -p ${PORT:-3000} --cors --gzip"]
