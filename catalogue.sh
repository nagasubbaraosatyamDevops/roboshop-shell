log=/tmp/roboshop.log
echo -e "\e[36m>>>>>>>>>>>> Create catalogue Service <<<<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>${log}

echo -e "\e[36m>>>>>>>>>>>> Create mongo repo <<<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}
dnf module disable nodejs -y &>>${log}
dnf module enable nodejs:18 -y &>>${log}

echo -e "\e[36m>>>>>>>>>>>> Install nodejs Repos <<<<<<<<<<<<\e[0m"
dnf install nodejs -y &>>${log}

echo -e "\e[36m>>>>>>>>>>>> Create Application user <<<<<<<<<<<<\e[0m"
useradd roboshop &>>${log}

echo -e "\e[36m>>>>>>>>>>>> Create Application user <<<<<<<<<<<<\e[0m"
rm -rf /app &>>${log}

echo -e "\e[36m>>>>>>>>>>>> Create Application Directory <<<<<<<<<<<<\e[0m"
mkdir /app &>>${log}

echo -e "\e[36m>>>>>>>>>>>> Download Application content <<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}

echo -e "\e[36m>>>>>>>>>>>> Extract Application content <<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip &>>${log}
cd /app

echo -e "\e[36m>>>>>>>>>>>> Download NodeJS Dependencies <<<<<<<<<<<<\e[0m"
npm install &>>${log}
echo -e "\e[36m>>>>>>>>>>>> Install Mongo Client <<<<<<<<<<<<\e[0m"
dnf install mongodb-org-shell -y &>>${log}

echo -e "\e[36m>>>>>>>>>>>> Load Catalogue Schema  <<<<<<<<<<<<\e[0m"
mongo --host mongodb.sdevopsb74.online </app/schema/catalogue.js &>>${log}

echo -e "\e[36m>>>>>>>>>>>> Start Catalogue Service <<<<<<<<<<<<\e[0m"
systemctl daemon-reload &>>${log}
systemctl enable catalogue &>>${log}
systemctl restart catalogue &>>${log}