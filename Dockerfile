# Everything below is now called builder (the 'builder phase')
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <-- now contains what we wanna serve in prod
# by just putting in a second "FROM" statement, we are starting a new block
FROM nginx

# 1. Copy from builder step
# 2. Copy to default nginx directory where content is being served from
COPY --from=builder /app/build /usr/share/nginx/html

# default command of nginx is gonna start it up for us, not need to specify it here.