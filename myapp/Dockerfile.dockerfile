# Use a stable Node LTS image
FROM node:18

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if present)
COPY package*.json ./

# Install production dependencies
RUN npm install --production

# Bundle app source
COPY . .

# The app listens on 8888
EXPOSE 8888

ENV NODE_ENV=production

CMD [ "node", "app.js" ]
