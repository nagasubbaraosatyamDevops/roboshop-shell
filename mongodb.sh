cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y
systemctl enable mongod
systemctl start mongod
#update listen address from 127.0.0.1 to 0.0.0.0
systemctl restart mongod

