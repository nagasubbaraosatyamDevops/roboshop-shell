echo -e "\e[36m>>>>>>>>>>>> Create catalogue Service <<<<<<<<<<<<\e[om"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>>>>>>>>>> Create mongo repo <<<<<<<<<<<<\e[om"
cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[36m>>>>>>>>>>>> Install nodejs Repos <<<<<<<<<<<<\e[om"
dnf install nodejs -y

echo -e "\e[36m>>>>>>>>>>>> Create Application user <<<<<<<<<<<<\e[om"
useradd roboshop

echo -e "\e[36m>>>>>>>>>>>> Create Application Directory <<<<<<<<<<<<\e[om"
mkdir /app

echo -e "\e[36m>>>>>>>>>>>> Download Application content <<<<<<<<<<<<\e[om"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[36m>>>>>>>>>>>> Extract Application content <<<<<<<<<<<<\e[om"
cd /app
unzip /tmp/catalogue.zip
cd /app

echo -e "\e[36m>>>>>>>>>>>> Download NodeJS Dependencies <<<<<<<<<<<<\e[om"
npm install
echo -e "\e[36m>>>>>>>>>>>> Install Mongo Client <<<<<<<<<<<<\e[om"
dnf install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>>>>> Load Catalogue Schema  <<<<<<<<<<<<\e[om"
mongo --host mongodb.sdevopsb74.online </app/schema/catalogue.js

echo -e "\e[36m>>>>>>>>>>>> Start Catalogue Service <<<<<<<<<<<<\e[om"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue