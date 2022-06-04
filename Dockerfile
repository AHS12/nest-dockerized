FROM node:14-alpine

# Create app directory
# RUN mkdir /var/www/app

# Set Working Directory
WORKDIR /var/www/nest_backend

# Install app dependencies - For NPM use: `COPY package.json package-lock.lock ./`
COPY package.json yarn.lock ./ 

# For NPM use: `RUN npm ci`
RUN yarn --pure-lockfile

# Copy important files - Add ormconfig.ts here if using Typeorm
COPY .eslintrc.js nest-cli.json tsconfig.json tsconfig.build.json ./

# Copy env
COPY .env /var/www/nest_backend/.env

# Add storage folder to the container (If you want to add other folder contents to the container)
# ADD storage /var/www/backend/storage

#Copy src and test folder
COPY src /var/www/nest_backend/src
COPY test /var/www/nest_backend/test

EXPOSE 5000

# Entrypoint command - Replace `"yarn"` with `"npm", "run"` if you are using NPM as your package manager.
# You can update this to run other NodeJS apps
CMD [ "yarn start:dev --preserveWatchOutput" ]

ENTRYPOINT [ "sh", "-c" ]