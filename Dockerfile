# Використовуємо базовий образ nginx
FROM nginx:latest

# Копіюємо файли веб-застосунку у папку за замовчуванням nginx (зазвичай /usr/share/nginx/html)

COPY index.html /usr/share/nginx/html
COPY style.css /usr/share/nginx/html

EXPOSE 80
