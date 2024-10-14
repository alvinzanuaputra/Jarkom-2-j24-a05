# NOMOR 6

echo '
nameserver 192.168.122.1
nameserver 10.6.2.3 ' > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

mkdir -p /etc/bind/vitamin
cp /etc/bind/db.local /etc/bind/vitamin/vitamin.brokoli.a05.com
cp /etc/bind/db.local /etc/bind/vitamin/k1.vitamin.brokoli.a05.com


echo ' 
zone "bayam.a05.com" {
    type slave;
    masters { 10.6.2.3; };
    file "/var/lib/bind/bayam.a05.com";
};

zone "brokoli.a05.com" {
    type slave;
    masters { 10.6.2.3; };
    file "/var/lib/bind/brokoli.a05.com";
};

zone "buncis.a05.com" {
    type slave;
    masters { 10.6.2.3; };
    file "/var/lib/bind/buncis.a05.com";
};


zone "pokcoy.a05.com" {
    type slave;
    masters { 10.6.2.3; }; 
    file "/var/lib/bind/pokcoy.a05.com";
};

' > /etc/bind/named.conf.local


ping pokcoy.a05.com -c 3
ping bayam.a05.com -c 3
ping brokoli.a05.com -c 3
ping buncis.a05.com -c 3

# NOMOR 7

echo -e '
zone "vitamin.brokoli.a05.com" {
    type master;
    file "/etc/bind/vitamin/vitamin.brokoli.a05.com";
};
' >> /etc/bind/named.conf.local


echo '
;
; BIND data file for vitamin.brokoli.a05.com
;
$TTL    604800
@       IN      SOA     vitamin.brokoli.a05.com. root.vitamin.brokoli.a05.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      vitamin.brokoli.a05.com.
@       IN      A       10.6.3.3       ; IP Brokoli
www     IN      CNAME   vitamin.brokoli.a05.com.
' > /etc/bind/vitamin/vitamin.brokoli.a05.com


echo "options {
    directory \"/var/cache/bind\";
    allow-query { any; };
    auth-nxdomain no;
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options



# NOMOR 8

echo '
$TTL    604800
@       IN      SOA     vitamin.brokoli.a05.com. root.vitamin.brokoli.a05.com. (
                        2023101001      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      vitamin.brokoli.a05.com.
@       IN      A       10.6.3.3       ; IP Brokoli
www     IN      CNAME   vitamin.brokoli.a05.com.
k1      IN      A       10.6.3.3
www.k1  IN      CNAME   k1.vitamin.brokoli.a05.com.
' > /etc/bind/vitamin/vitamin.brokoli.a05.com


service bind9 restart


# client : 
# echo -e '
# nameserver 10.6.4.2
# nameserver 10.6.2.3
# nameserver 192.168.122.1
# ' > /etc/resolv.conf

# ping k1.vitamin.brokoli.a05.com -c  3
# ping www.k1.vitamin.brokoli.a05.com -c 3