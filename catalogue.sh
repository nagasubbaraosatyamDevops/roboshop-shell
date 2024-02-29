echo -e "\e[36m>>>>>>>>>>>> Create catalogue Service <<<<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>>>>>>>>>> Create mongo repo <<<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "\e[36m>>>>>>>>>>>> Install nodejs Repos <<<<<<<<<<<<\e[0m"
dnf install nodejs -y

echo -e "\e[36m>>>>>>>>>>>> Create Application user <<<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>>>>> Create Application user <<<<<<<<<<<<\e[0m"
rm -rf /app

echo -e "\e[36m>>>>>>>>>>>> Create Application Directory <<<<<<<<<<<<\e[0m"
mkdir /app

echo -e "\e[36m>>>>>>>>>>>> Download Application content <<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[36m>>>>>>>>>>>> Extract Application content <<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip
cd /app

echo -e "\e[36m>>>>>>>>>>>> Download NodeJS Dependencies <<<<<<<<<<<<\e[0m"
npm install
echo -e "\e[36m>>>>>>>>>>>> Install Mongo Client <<<<<<<<<<<<\e[0m"
dnf install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>>>>> Load Catalogue Schema  <<<<<<<<<<<<\e[0m"
mongo --host mongodb.sdevopsb74.online </app/schema/catalogue.js

echo -e "\e[36m>>>>>>>>>>>> Start Catalogue Service <<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue