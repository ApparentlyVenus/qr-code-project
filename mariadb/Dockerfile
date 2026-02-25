FROM mariadb:10.11

COPY init.cnf /etc/mysql/conf.d/

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306