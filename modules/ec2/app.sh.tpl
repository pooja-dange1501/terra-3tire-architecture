#!/bin/bash
set -ex

apt update -y
apt install -y apache2 php php-mysql mysql-client

systemctl enable apache2
systemctl start apache2

mkdir -p /var/www/html

# ---------- WAIT FOR DB ----------
DB_HOST=$(echo ${rds_endpoint} | cut -d: -f1)

until mysql -h $DB_HOST -u admin -p${db_password} -e "SELECT 1"; do
  echo "Waiting for DB..."
  sleep 5
done

# ---------- DB SETUP ----------
mysql -h $DB_HOST -u admin -p${db_password} <<EOF
CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  course VARCHAR(50),
  mobile VARCHAR(20)
);
EOF

# ---------- IMPORTANT FIX (NO NOT FOUND) ----------
echo "OK APP SERVER" > /var/www/html/index.html

# ---------- SUBMIT FILE ----------
cat <<EOF > /var/www/html/submit.php
<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

if (\$_SERVER["REQUEST_METHOD"] == "POST") {

    \$conn = new mysqli("$DB_HOST","admin","${db_password}","mydb");

    if (\$conn->connect_error) {
        die("DB Connection failed: " . \$conn->connect_error);
    }

    \$stmt = \$conn->prepare("INSERT INTO users (name,email,course,mobile) VALUES (?,?,?,?)");
    \$stmt->bind_param("ssss", \$_POST['name'], \$_POST['email'], \$_POST['course'], \$_POST['mobile']);

    if (\$stmt->execute()) {
        echo "✅ Data Saved Successfully";
        echo "<br><br><a href='/index.php'>Go Back</a>";
    } else {
        echo "Error: " . \$stmt->error;
    }

    \$conn->close();

} else {
    echo "Invalid Request";
}
?>
EOF

systemctl restart apache2

chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html