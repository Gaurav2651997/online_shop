#Declaring the base image
FROM node:18-alpine

#Declaring the Workdir
WORKDIR /app

#Copying the project files
COPY . .

#Creating the build
RUN npm install && npm run build

#Creating a environment variable
ENV PORT=3000

#Exposing the Port
EXPOSE 3000

#Run the application
CMD ["npm","run","dev","--","--host","0.0.0.0","--port","3000"]
