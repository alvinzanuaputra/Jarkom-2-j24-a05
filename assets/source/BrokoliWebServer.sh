#  UNTUK BROKOLI INI DI NOMER 9 SAMPAI 20 tidak bisa langsung bashrc, harus dijalankan satu persatu karena ada kombinasi restart dan stop service

echo -e '
nameserver 10.6.2.3 
nameserver 10.6.4.2 
nameserver 192.168.122.1
' > /etc/resolv.conf

# nomor9

apt-get update                                                             
apt-get install nginx -y                                                 
apt-get install lynx -y
apt-get install apache2 -y
apt-get install php -y

apt-get install unzip -y
apt-get install php7.2-fpm  -y




wget --no-check-certificate --content-disposition "https://docs.google.com/uc?export=download&id=1tFDk7pKRQLd3BMUcyvfAfEL-drvIxdSl"
unzip sayur_webserver_nginx

# -- cek (php pke yg 7.2)
service nginx status
service php7.2-fpm status

service nginx start
service php7.2-fpm start

# ini buat hostnya :
# echo '                                                                  
# 10.6.1.3 Bayam                                                         
# 10.6.2.2 Buncis
# 10.6.3.3 Brokoli
# ' > /etc/hosts

# -- contoh pake brokoli

# cd /etc/nginx/sites-available/
# nano brokoli.a05.com

echo '
server {

	listen 80;

	root /var/www/brokoli.a05.com;

	index index.php index.html index.htm;
	server_name brokoli.a05.com www.brokoli.a05.com;

	location / {
			try_files $uri $uri/ /index.php?$query_string;
	}

	# pass PHP scripts to FastCGI server
	location ~ \.php$ {
	include snippets/fastcgi-php.conf;
	fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
	}

location ~ /\.ht {
			deny all;
	}

	error_log /var/log/nginx/error.log;
	access_log /var/log/nginx/access.log;
} ' > /etc/nginx/sites-available/brokoli.a05.com

ln -s /etc/nginx/sites-available/brokoli.a05.com /etc/nginx/sites-enabled/brokoli.a05.com

mkdir -p /var/www/brokoli.a05.com

cd


mv sayur_webserver_nginx/* /var/www/brokoli.a05.com

cd /var/www/brokoli.a05.com

ls 

# -- spy resepnya muncul, harus ganti hostname

cd

hostname Brokoli

# -- pindah ke client lalu lynx

service nginx restart

# ini nyoba di client
# lynx brokoli.a05.com

# cek history nya di brokoli/webserver lain
cat /var/log/nginx/error.log
cat /var/log/nginx/access.log

# nomor 10
cd /var/www/brokoli.a05.com
mv resep3.php resep_3.php
service nginx restart


# nomor 11 

# nano /etc/nginx/nginx.conf

# masukin ini :

echo '
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
    worker_connections 768;
}

http {
    map $host $worker_name {
        default "Unknown";  # Jika hostname tidak dikenali
        "10.6.1.3" "Bayam";
        "10.6.2.2" "Buncis";
        "10.6.3.3" "Brokoli";
    }

    log_format custom_log '[\$time_local] Jarkom Node $hostname Access from $remote_addr using method "\$request" returned status \$status with \$body_bytes_sent bytes sent in \$request_time seconds';


    ## Basic Settings
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    ## SSL Settings
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
    ssl_prefer_server_ciphers on;

    ## Logging Settings
    access_log /var/log/nginx/access.log custom_log;
    error_log /var/log/nginx/error.log;

    ## Gzip Settings
    gzip on;

    ## Virtual Host Configs
    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;

    # Konfigurasi Server
    server {
        listen 80;  # Ganti dengan port yang sesuai
        server_name 10.6.1.3 10.6.2.2 10.6.3.3;  # Nama server untuk IP yang digunakan

        location / {
            # Logika pemrosesan untuk masing-masing worker_name jika diperlukan
            # Misalnya, bisa menambahkan pengaturan proxy_pass di sini
        }
    }
}
' > /etc/nginx/nginx.conf

# 
# nano /etc/nginx/sites-available/brokoli.a05.com

# masukin ini :

echo '
server {

        listen 80;

        root /var/www/brokoli.a05.com;

		index index.php resep_1.php resep_2.php resep_3.php;
        # index index.php index.html index.htm;
        server_name brokoli.a05.com www.brokoli.a05.com;

		access_log /var/log/nginx/access.log custom_log;
        error_log /var/log/nginx/error.log;

        location / {
                        # try_files $uri $uri/ /index.php?$query_string;
						try_files $uri $uri/ =404;
        }

        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        }

location ~ /\.ht {
                        deny all;
        }

        # error_log /var/log/nginx/error.log;
        # access_log /var/log/nginx/access.log;
} ' > /etc/nginx/sites-available/brokoli.a05.com

service nginx restart

# coba lynx lagi di client
# lynx brokoli.a05.com

# cek di brokoli lagi setelah akses
cat /var/log/nginx/access.log
cat /var/log/nginx/error.log


# nomor 12

service nginx stop

# ke root lagi
wget --no-check-certificate --content-disposition "https://docs.google.com/uc?export=download&id=1NhsaTLD4Zk06BZJCqdN_oqoxB3uIg2C7"

unzip vitamin.brokoli.yyy.com

mkdir -p /var/www/vitamin.brokoli.yyy.com

mv vitamin.brokoli.yyy.com/* /var/www/vitamin.brokoli.yyy.com

chown -R www-data:www-data /var/www/vitamin.brokoli.yyy.com


# nano /etc/apache2/sites-enabled/vitamin.brokoli.yyy.com.conf

echo '
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/vitamin.brokoli.yyy.com
  ServerName vitamin.brokoli.a05.com
  ServerAlias www.vitamin.brokoli.a05.com
  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
' > /etc/apache2/sites-enabled/vitamin.brokoli.yyy.com.conf

# nano /etc/apache2/sites-available/vitamin.conf

echo '
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/vitamin.brokoli.yyy.com
  ServerName vitamin.brokoli.a05.com
  ServerAlias www.vitamin.brokoli.a05.com
  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

' > /etc/apache2/sites-available/vitamin.conf


a2ensite vitamin.conf
service apache2 reload
service apache2 restart

# di client
# lynx vitamin.brokoli.a05.com

# nomor 13
# nano /etc/apache2/sites-enabled/vitamin.brokoli.yyy.com.conf

echo '
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/vitamin.brokoli.yyy.com
  ServerName vitamin.brokoli.a05.com
  ServerAlias www.vitamin.brokoli.a05.com
  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
<Directory /var/www/vitamin.brokoli.yyy.com>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

  RewriteEngine On
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteRule ^([^\.]+)$ $1.php [NC,L]

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost> ' > /etc/apache2/sites-enabled/vitamin.brokoli.yyy.com.conf


a2enmod rewrite
service apache2 restart


# di client
# lynx vitamin.brokoli.a05.com
# enter 
# enter


# nomor 14

# nano /etc/apache2/sites-enabled/vitamin.brokoli.yyy.com.conf

echo '
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/vitamin.brokoli.yyy.com
  ServerName vitamin.brokoli.a05.com
  ServerAlias www.vitamin.brokoli.a05.com
  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
<Directory /var/www/vitamin.brokoli.yyy.com>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

  # RewriteEngine On
  # RewriteCond %{REQUEST_FILENAME} !-d
  # RewriteRule ^([^\.]+)$ $1.php [NC,L]
  <Directory /var/www/vitamin.brokoli.yyy.com/public/images>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
  </Directory>

 Alias "/img" "/var/www/vitamin.brokoli.yyy.com/public/images"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
' > /etc/apache2/sites-enabled/vitamin.brokoli.yyy.com.conf

# lynx vitamin.brokoli.a05.com/img


# nomor 15 

# nano /etc/apache2/sites-enabled/vitamin.brokoli.yyy.com.conf

echo '
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/vitamin.brokoli.yyy.com
  ServerName vitamin.brokoli.a05.com
  ServerAlias www.vitamin.brokoli.a05.com
  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
<Directory /var/www/vitamin.brokoli.yyy.com>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

  # RewriteEngine On
  # RewriteCond %{REQUEST_FILENAME} !-d
  # RewriteRule ^([^\.]+)$ $1.php [NC,L]
  <Directory /var/www/vitamin.brokoli.yyy.com/public/images>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
  </Directory>

  <Directory /var/www/vitamin.brokoli.yyy.com/secret>
          Options -Indexes
  </Directory>

Alias "/secret" "/var/www/vitamin.brokoli.yyy.com/secret"

 Alias "/img" "/var/www/vitamin.brokoli.yyy.com/public/images"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
' > /etc/apache2/sites-enabled/vitamin.brokoli.yyy.com.conf


service apache2 restart

# lynx vitamin.brokoli.a05.com/secret


# nomor 16

# nano /etc/apache2/sites-enabled/vitamin.brokoli.yyy.com.conf

echo '
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/vitamin.brokoli.yyy.com
  ServerName vitamin.brokoli.a05.com
  ServerAlias www.vitamin.brokoli.a05.com
  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
<Directory /var/www/vitamin.brokoli.yyy.com>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

  # RewriteEngine On
  # RewriteCond %{REQUEST_FILENAME} !-d
  # RewriteRule ^([^\.]+)$ $1.php [NC,L]
  <Directory /var/www/vitamin.brokoli.yyy.com/public/images>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
  </Directory>

  <Directory /var/www/vitamin.brokoli.yyy.com/secret>
          Options -Indexes
  </Directory>

<Directory /var/www/vitamin.brokoli.yyy.com/public/js>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
  </Directory>

Alias "/js" "/var/www/vitamin.brokoli.yyy.com/public/js"
Alias "/secret" "/var/www/vitamin.brokoli.yyy.com/secret"

 Alias "/img" "/var/www/vitamin.brokoli.yyy.com/public/images"

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
' > /etc/apache2/sites-enabled/vitamin.brokoli.yyy.com.conf

# lynx vitamin.brokoli.a05.com/js

# nomor 17


wget --no-check-certificate --content-disposition "https://docs.google.com/uc?export=download&id=1SRnelY4XrtmhJg_Ly1nUJo1Jf91SnmtB"

unzip k1.vitamin.brokoli.yyy.com.zip


mkdir -p /var/www/k1.vitamin.brokoli.yyy.com

mv k1.vitamin.brokoli.yyy.com/* /var/www/k1.vitamin.brokoli.yyy.com

chown -R www-data:www-data /var/www/k1.vitamin.brokoli.yyy.com


# nano /etc/apache2/sites-available/k1.vitamin.brokoli.a05.com.conf

echo '
<VirtualHost *:9696 *:8888>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/k1.vitamin.brokoli.yyy.com
  ServerName k1.vitamin.brokoli.a05.com
  ServerAlias www.k1.vitamin.brokoli.a05.com

<Directory /var/www/k1.vitamin.brokoli.yyy.com>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
  </Directory>
  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
' > /etc/apache2/sites-available/k1.vitamin.brokoli.a05.com.conf

# nano /etc/apache2/ports.conf 

# tambahkan port 9696 dan 8888

echo '
Listen 80
Listen 9696
Listen 8888

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>
'> /etc/apache2/ports.conf 

a2ensite k1.vitamin.brokoli.a05.com.conf
service apache2 reload
service apache2 restart


# lynx k1.vitamin.brokoli.a05.com:9696
# lynx k1.vitamin.brokoli.a05.com:8888


# nomor 18
htpasswd -c -b /etc/apache2/.htpasswd Seblak sehata05

# nano  /etc/apache2/sites-available/k1.vitamin.brokoli.a05.com.conf

echo '
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/k1.vitamin.brokoli.yyy.com
  ServerName k1.vitamin.brokoli.a05.com
  ServerAlias www.k1.vitamin.brokoli.a05.com

<Directory /var/www/k1.vitamin.brokoli.yyy.com>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
  </Directory>

 <Directory /var/www/k1.vitamin.brokoli.yyy.com>
          AuthType Basic
          AuthName "Restricted Content"
          AuthUserFile /etc/apache2/.htpasswd
          Require valid-user
  </Directory>
  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
' > /etc/apache2/sites-available/k1.vitamin.brokoli.a05.com.conf


service apache2 restart

# lynx k1.vitamin.brokoli.a05.com

# nomor 19


# nano /etc/apache2/sites-available/ipbrokoli.conf
# nano /etc/apache2/sites-available/000-default.conf

echo '
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/brokoli.a05.com

  ServerName brokoli.a05.com
  ServerAlias www.brokoli.a05.com

  RewriteEngine On

  RewriteCond %{HTTP_HOST} ^10\.6\.3\.3$
  RewriteRule ^(.*)$ http://www.brokoli.a05.com/$1 [L,R=301]

</VirtualHost>
'> /etc/apache2/sites-available/000-default.conf

a2enmod rewrite
service apache2 restart

# client
# lynx www.brokoli.a05.com
# lynx 10.6.3.3

# nomor 20

echo -e '
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/vitamin.brokoli.yyy.com
  ServerName vitamin.brokoli.a05.com
  ServerAlias www.vitamin.brokoli.a05.com

<Directory /var/www/vitamin.brokoli.yyy.com>

RewriteEngine On
RewriteCond %{REQUEST_URI} \.(jpg|png)$ [NC]
RewriteCond %{REQUEST_URI} vitamin [NC]
RewriteCond %{REQUEST_URI} !^/public/images/vitamin\.png [NC]
RewriteRule ^(.*)$ http://www.vitamin.brokoli.a05.com/public/images/vitamin.png
  </Directory>


<Directory /var/www/vitamin.brokoli.yyy.com/secret>
          Options -Indexes
  </Directory>

Alias "/secret" "/var/www/vitamin.brokoli.yyy.com/secret"
  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-enabled/vitamin.brokoli.a05.com.conf

a2enmod rewrite
service apache2 restart


echo -e '
<Directory /var/www/vitamin.brokoli.yyy.com> 
RewriteCond %{REQUEST_URI} \.(jpg|png)$ [NC] 
RewriteCond %{REQUEST_URI} vitamin [NC]
RewriteCond %{REQUEST_URI} !^/public/images/vitamin\.png
</Directory>
'> /var/www/vitamin.brokoli.yyy.com/.htaccess

a2enmod rewrite
service apache2 restart


# lynx www.vitamin.brokoli.a05.com/public/images/vitamin.png
# lynx www.vitamin.brokoli.a05.com/public/images/not-vitamin.jpg