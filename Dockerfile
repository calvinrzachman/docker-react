# This is a Production Dockerfile

# BUILD PHASE
# Use an existing Docker image as a base
FROM node:alpine as builder
WORKDIR /app

# Add files (package.json and index) to the containers files
COPY ./package.json ./ 
# this adds only whats required for npm install so that we save time
# on each rebuild

# Download and install a dependency
RUN npm install
COPY ./ ./ 

# Tell image what to do on container start
RUN ["npm", "run", "build"]


# RUN PHASE
FROM nginx
EXPOSE 80
COPY --from=builder /app/build ./usr/share/nginx/html