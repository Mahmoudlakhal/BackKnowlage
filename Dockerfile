<<<<<<< HEAD
# Use an OpenJDK base image
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from your project into the container
COPY ./target/Pi_Spring-0.0.1-SNAPSHOT.jar /app/Pi_Spring-0.0.1-SNAPSHOT.jar

# Expose the port your Spring Boot application runs on (change to the actual port)
EXPOSE 8089


# Define the command to run your Spring Boot application
CMD ["java", "-jar", "Pi_Spring-0.0.1-SNAPSHOT.jar"]
=======
### STAGE 1:BUILD ###

FROM node:18.16.1-alpine AS build
# Create a Virtual directory inside the docker image
WORKDIR /dist/src/app
# Copy files to virtual directory

RUN npm cache clean --force
# Copy files from local machine to virtual directory in docker image
COPY . .
RUN npm install --force
RUN npm run build --prod
### STAGE 2:RUN ###
# Defining nginx image to be used
FROM nginx:latest AS ngi
# Copying compiled code and nginx config to different folder
# NOTE: This path may change according to your project's output folder
COPY --from=build /dist/src/app/dist/Estore /usr/share/nginx/html
COPY /nginx.config  /etc/nginx/conf.d/default.conf
# Exposing a port, here it means that inside the container
# the app will be using Port 80 while running
EXPOSE 80
>>>>>>> 3d7f0f27928558894c64bd7c10a9694e686925ec
