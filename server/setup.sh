#!/bin/bash
# ============================================
# Налаштування gapta.com.ua на Hetzner сервері
# Запускати від root на сервері
# ============================================

set -e

DOMAIN="gapta.com.ua"
ALT_DOMAINS="gapta.rivne.ua gapta.rv.ua"
WEB_ROOT="/var/www/${DOMAIN}"
NGINX_CONF="/etc/nginx/sites-available/${DOMAIN}.conf"
NGINX_ENABLED="/etc/nginx/sites-enabled/${DOMAIN}.conf"

echo "=== 1. Створення директорії для сайту ==="
mkdir -p ${WEB_ROOT}
chown -R www-data:www-data ${WEB_ROOT}

echo "=== 2. Створення тимчасової заглушки ==="
cat > ${WEB_ROOT}/index.html << 'PLACEHOLDER'
<!DOCTYPE html>
<html lang="uk">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GAPTA — Скоро відкриття</title>
  <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{min-height:100vh;background:#0f172a;display:flex;align-items:center;justify-content:center;font-family:system-ui,sans-serif;color:#e2e8f0}
    .c{text-align:center;padding:2rem}
    .logo{width:80px;height:80px;background:linear-gradient(135deg,#3b82f6,#10b981);border-radius:1rem;display:inline-flex;align-items:center;justify-content:center;margin-bottom:1.5rem;font-size:2rem;font-weight:900;color:#fff}
    h1{font-size:3rem;margin-bottom:.5rem}
    .line{width:4rem;height:4px;background:linear-gradient(90deg,#3b82f6,#10b981);border-radius:2px;margin:0 auto 1.5rem}
    p{color:#94a3b8;margin-bottom:.5rem}
    .d{font-size:.875rem;color:#64748b;margin-top:2rem}
  </style>
</head>
<body>
  <div class="c">
    <div class="logo">G</div>
    <h1>GAPTA</h1>
    <div class="line"></div>
    <p>Сайт на стадії розробки</p>
    <p>Ми працюємо над новим сайтом.</p>
    <div class="d">gapta.com.ua · gapta.rivne.ua · gapta.rv.ua</div>
  </div>
</body>
</html>
PLACEHOLDER

echo "=== 3. Копіювання Nginx конфігу ==="
# Спочатку — тільки HTTP (без SSL), щоб отримати сертифікат
cat > ${NGINX_CONF} << 'NGINXHTTP'
server {
    listen 80;
    listen [::]:80;
    server_name gapta.com.ua gapta.rivne.ua gapta.rv.ua;

    root /var/www/gapta.com.ua;
    index index.html;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        try_files $uri $uri/ $uri.html /index.html =404;
    }
}
NGINXHTTP

echo "=== 4. Активація сайту ==="
ln -sf ${NGINX_CONF} ${NGINX_ENABLED}
nginx -t && systemctl reload nginx

echo "=== 5. Отримання SSL-сертифіката ==="
mkdir -p /var/www/certbot
certbot certonly --webroot -w /var/www/certbot \
  -d gapta.com.ua \
  -d gapta.rivne.ua \
  -d gapta.rv.ua \
  --non-interactive --agree-tos --email admin@gapta.com.ua

echo "=== 6. Оновлення Nginx на HTTPS ==="
# Тепер підміняємо на повний конфіг з SSL
# (скопіюй gapta.com.ua.conf з репозиторію)
echo ">>> Скопіюй повний конфіг з server/nginx/gapta.com.ua.conf"
echo ">>> в ${NGINX_CONF} і виконай: nginx -t && systemctl reload nginx"

echo ""
echo "=== Готово! ==="
echo "Заглушка доступна на http://${DOMAIN}"
echo ""
echo "Наступні кроки:"
echo "1. Направити DNS всіх 3 доменів на IP сервера"
echo "2. Отримати SSL-сертифікат (крок 5)"
echo "3. Підмінити Nginx конфіг на HTTPS-версію"
echo "4. Налаштувати GitHub Actions secrets для автодеплою"
