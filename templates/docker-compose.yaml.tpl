version: '3.3'
services:
  wordpress:
    image: wordpress:latest
    depends_on:
    - db
    ports:
    - "8000:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: ${db_host}:${db_port}
      WORDPRESS_DB_USER: ${db_user}
      WORDPRESS_DB_PASSWORD: ${db_password}
      WORDPRESS_DB_NAME: ${db_dbname}
    volumes:
    - type: volume
      source: /opt/wordpress
      target: /var/www/html
      # Using a docker-volume to persist data between containers/restarts, 
      # for local development, but I wonder if anyone  has ever published 
      # how to mount AWS-EFS to a docker container?
volumes:
  db_data: {}
  persistent_data: {}
