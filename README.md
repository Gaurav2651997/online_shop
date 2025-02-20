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


