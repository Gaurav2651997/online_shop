# Online Shop 🛍️ for Hackathon Phase 1
[![Stars](https://img.shields.io/github/stars/iemafzalhassan/online_shop)](https://github.com/iemafzalhassan/online_shop)
![Forks](https://img.shields.io/github/forks/iemafzalhassan/online_shop)
![GitHub last commit](https://img.shields.io/github/last-commit/iemafzalhassan/easyshop?color=red)
[![GitHub Profile](https://img.shields.io/badge/GitHub-iemafzalhassan-blue?logo=github&style=flat)](https://github.com/iemafzalhassan)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
<p align="center">

Welcome to the **Online Shop** project – our hackathon entry for Phase 1! This repository contains a fully functional e-commerce application built to demonstrate foundational DevOps skills in three key areas:
- **Git & GitHub**
- **Linux**
- **Docker**

---
Overview
In this we will try to convert the Node.js application to a Docker Containerized running Application. Also we will be seeing how we can reduce the size of the docker image and run the docker application with minimal and the optimal size.

---
So in order to understand the approach for dockerizing any application, it is always a best idea to run it first in our local environment.💻 

---
Part 1 (Running the Image Locally)

So Lets start with running the application locally. Below are the steps involved ⬇

1️⃣ cd to online_shop directory.

2️⃣ install the npm packge with coammand -> sudo apt-get install npm -y

2️⃣ If you want to verify if it has successfully installed or want to know it's where it is located then you can do so by the below commmand.

ubuntu@ip-172-31-92-158:~/Hackathon/online_shop$ whereis npm
npm: /usr/bin/npm /usr/share/npm /usr/share/man/man1/npm.1.gz

3️⃣ Now Run -> npm install (This command is used to install all the dependencies (libraries and packages) your project needs to run)

4️⃣ After this run -> npm build (This command is used to prepare your app for production, meaning making it ready for deployment).

5️⃣ The above 2 commands will generate node_modules, package-lock.json and dist directories.

6️⃣ Now Run -> npm run dev (This will run your application)

ubuntu@ip-172-31-92-158:~/Hackathon/online_shop$ npm run dev

> online-shop@0.0.0 dev
> vite --host


  VITE v5.4.14  ready in 418 ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: http://172.31.92.158:5173/
  ➜  press h + enter to show help
Deprecation Warning [legacy-js-api]: The legacy JS API is deprecated and will be removed in Dart Sass 2.0.0.

More info: https://sass-lang.com/d/legacy-js-api

7️⃣ Now check if your application will be running on port 5173

![image](https://github.com/user-attachments/assets/1295cf0e-e374-4661-a8d2-aeeb83ffbeca)

---

Part 2 (Running the application inside the Docker Container)

Since we have successfully ran our application locally, nnow it's time to dockerize our application.🚀

Creating a Docker file for the application - We need to follow the same steps which we followed while running it Locally

1️⃣ Declaring the base image -> Here we choose node:18-alpine

2️⃣ Declaring the Workdir -> In our case it's /app

3️⃣ Copying all the application files require to run our application -> COPY . .  (Here 2st dot resembles Source which is our local machine and 2nd dot resembles destination which is our conatiner)

4️⃣ Creating the build and installing all the necessary dependencies -> npm install && npm run build

5️⃣ Creating a environment variable for Port no -> ENV PORT=3000 

6️⃣ Exposing the conatiner Port outside inorder to make it accessible -> EXPOSE 3000 

7️⃣ Run the application. CMD needs all the necessary parameters to run the application inside the container. Hence this is the command. -> CMD ["npm","run","dev","--","--host","0.0.0.0","--port","3000"]

Below is the Docker file -

Dockerfile

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

8️⃣ Now build the image with this command -> docker build -t online_shop:latest .

9️⃣ Your docker image will be created. To check run -> docker iamges

ubuntu@ip-172-31-92-158:~/Hackathon/online_shop$ docker images
REPOSITORY    TAG         IMAGE ID       CREATED          SIZE
online_shop   latest      e3e3636ddaa6   11 minutes ago   241MB
node          18-alpine   70649fe1a0d7   9 hours ago      127MB

🔟 Now run the conatiner with this command -> docker run -p 3000:3000 online_shop:latest (Use -d if you want to run it in detached mode i.e docker run -d -p 3000:3000 online_shop:latest )

Open the port 3000 on your AWS Security Group -> Edit the inbound rules and add the 3000 port. Now Copy the public i/p and try accesing your application on port 3000

![image](https://github.com/user-attachments/assets/881c48d4-d903-40cf-8884-e8b274c6ff85)


Here i also tried to use a slim image but it was taking more size than alpine so i choose to go with alpine

PFB -

when alpine image was used

ubuntu@ip-172-31-92-158:~/Hackathon/online_shop$ docker images
REPOSITORY    TAG         IMAGE ID       CREATED          SIZE
**online_shop**   latest      e3e3636ddaa6   11 minutes ago   **241MB**
node          **18-alpine**   70649fe1a0d7   9 hours ago      **127MB**


When slim iamge was used
ubuntu@ip-172-31-92-158:~$ docker images
REPOSITORY    TAG         IMAGE ID       CREATED              SIZE
**online_shop**   latest      de7d09bf36f5   About a minute ago   **306MB**
<none>        <none>      e3e3636ddaa6   15 minutes ago       241MB
node          **18-slim**     b4486da599d9   9 hours ago          **192MB**
node          18-alpine   70649fe1a0d7   9 hours ago          127MB


**So better go for alpine image if you want to save the size of the application**

---

Part 3 (Running the application inside the Docker Container using multi stage Docker build)
If you want to further optimize the size of your application then you can use multi stage docker build.

In this file there will be few changes as follows

1️⃣ Here we will be having 2 stage so in Stage 1 we will only be installing the dependencies and building the code. Hence the docker file starts with the base image declaration and naming it with ALIAS -> FROM node:18-alpine AS builder

After the above the code will remain same as below

#Declaring the Workdir
WORKDIR /app

#Copying the project files
COPY . .

#Creating the build
RUN npm install && npm run build

2️⃣ Here in the 2nd Stage we are going to use the distroless image which is light in weight and does not occupy to much size -> FROM gcr.io/distroless/nodejs18-debian12

After this we would be decalring the Working directory which we usually do in our normal Docker file

3️⃣ Now we have to copy the dependencies from the Stage 1 -> 

COPY --from=builder /app/dist /app/dist
COPY --from=builder /app/node_modules /app/node_modules

After this exposing the port which we already know in normal Docker file

Atlast we need to run the application with CMD command -> CMD ["./node_modules/.bin/serve","-s","dist","-l","5173"]

./node_modules/.bin/serve -> This is the command to run a package called serve
-s -> means serve in static mode
dist -> is the folder that contains the built (compiled) version of your app
-l -> is an option for "listen". It tells the serve command which port to listen on for incoming requests
5173 -> is the port number where your app will be available.

Below is the multistage Docker file

ubuntu@ip-172-31-92-158:~/Hackathon/online_shop$ cat Dockerfile-multistage
#Stage 1
#Declaring the base image
FROM node:18-alpine AS builder

#Declaring the Workdir
WORKDIR /app

#Copying the project files
COPY . .

#Creating the build
RUN npm install && npm run build

#Stage 2
#Using the distroless image
FROM gcr.io/distroless/nodejs18-debian12

#Declaring the Workdir
WORKDIR /app

#Copying the dependencies from the Stage 1
COPY --from=builder /app/dist /app/dist
COPY --from=builder /app/node_modules /app/node_modules

#Exposing the Port
EXPOSE 5173

#Run the application
CMD ["./node_modules/.bin/serve","-s","dist","-l","5173"]


4️⃣ We also need to update package.json file. Goto package.json and under dependencies add this line at the end "serve": "^14.0.0"

Now build the image and run the conatiner 

docker build -t online_shop-mini:latest -f Dockerfile-multistage .
docker run -d -p 5173:300 online_shop-mini:latest

![image](https://github.com/user-attachments/assets/bea31d19-9157-4797-80c9-30a80a67b634)

While running i also faced an issue which was port already in use. I identified the running process id and killed it gracefully. Below are the steps

ps -ef | grep $USER

The application was running locally on the port 5173, so i killed the below 2 processes with kill -9 18708 18709
ubuntu     18708   18693  0 22:52 pts/1    00:00:00 sh -c vite --host
ubuntu     18709   18708  0 22:52 pts/1    00:00:04 node /home/ubuntu/Hackathon/online_shop/node_modules/.bin/vite --host

And re-ran the container and it was successfully started.

ubuntu@ip-172-31-92-158:~/Hackathon/online_shop$ docker images
REPOSITORY                            TAG         IMAGE ID       CREATED          SIZE
**online_shop-mini**                      latest      ab6b83a3ce77   12 minutes ago   **228MB**
<none>                                <none>      94d584bf1470   13 minutes ago   252MB
node                                  18-alpine   70649fe1a0d7   13 hours ago     127MB
gcr.io/distroless/nodejs18-debian12   latest      bb3148467fc6   N/A              115MB

docker ps

CONTAINER ID   IMAGE                     COMMAND                  CREATED         STATUS         PORTS                                       NAMES
554cd55b4e49   **online_shop-mini:latest**   "/nodejs/bin/node ./…"   7 minutes ago   Up 7 minutes   0.0.0.0:3000->5173/tcp, :::3000->5173/tcp   bold_vaughan


**🚀🚀🚀 Boom You application is Running with Multi Stage Docker file 🚀🚀🚀**


Now Since we have the working image we can push it into our Dockerhub Repository and use it whwnever we need. Below are the Commands

docker tag online_shop-mini:latest 2651997/online_shop-mini:latest

docker login

docker push 2651997/online_shop-mini:latest

![image](https://github.com/user-attachments/assets/e5cbaf9a-c5f6-42bf-bf42-9d62c8fea3b3)



Thank You!!!
---


