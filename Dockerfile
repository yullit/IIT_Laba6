# Використовуємо базовий образ nginx
FROM nginx:latest

# Копіюємо файли веб-застосунку у папку за замовчуванням nginx (зазвичай /usr/share/nginx/html)

COPY index.html /usr/share/nginx/html
COPY styles.css /usr/share/nginx/html

EXPOSE 80
