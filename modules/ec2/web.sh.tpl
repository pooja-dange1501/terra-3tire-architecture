#!/bin/bash
set -ex
export DEBIAN_FRONTEND=noninteractive

apt update -y
apt install -y nginx php8.3-fpm

systemctl enable nginx
systemctl start nginx

systemctl enable php8.3-fpm
systemctl start php8.3-fpm

mkdir -p /var/www/html

# ---------- FORM ----------
cat <<'EOF' > /var/www/html/index.php
<!DOCTYPE html>
<html>
<head>
    <title>Student Registration</title>

    <style>
        body {
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(to right,white);
            font-family: Arial, sans-serif;
        }

        .form-box {
            width: 360px;
            background: #4b42a4;        /* light grey card */
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #1e293b;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #cbd5e1;
            border-radius: 5px;
            background: #e2e8f0;
        }

        button {
            width: 100%;
            padding: 10px;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background: #1d4ed8;
        }
    </style>
</head>
<body>

<div class="form-box">

<h2>Student Registration</h2>

<form action="/submit.php" method="POST">
<input type="text" name="name" placeholder="Name" required><br><br>
<input type="email" name="email" placeholder="Email" required><br><br>

<select name="course">
<option>AWS</option>
<option>DevOps</option>
<option>Cloud</option>
</select><br><br>

<input type="text" name="mobile" placeholder="Mobile" required><br><br>

<button type="submit">Register</button>
</form>

</body>
</html>
EOF

# ---------- NGINX CONFIG ----------
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name _;

    root /var/www/html;
    index index.php index.html;

    # 🔥 HIGHEST PRIORITY (exact match)
    location = /submit.php {
        proxy_pass http://${app_private_ip}/submit.php;
    }

    # बाकी requests
    location / {
        try_files \$uri \$uri/ =404;
    }

    # PHP handler
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.3-fpm.sock;
    }
}
EOF

systemctl restart nginx

chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html