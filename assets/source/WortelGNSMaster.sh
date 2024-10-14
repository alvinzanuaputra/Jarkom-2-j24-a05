echo 'nameserver 192.168.122.1' >/etc/resolv.conf
apt-get update
apt-get install bind9 -y
apt-get install dnsutils

cp /etc/bind/db.local /etc/bind/jarkom/bayam.a05.com
cp /etc/bind/db.local /etc/bind/jarkom/brokoli.a05.com
cp /etc/bind/db.local /etc/bind/jarkom/buncis.a05.com
cp /etc/bind/db.local /etc/bind/jarkom/1.6.10.in-addr.arpa
cp /etc/bind/db.local /etc/bind/jarkom/2.6.10.in-addr.arpa
cp /etc/bind/db.local /etc/bind/jarkom/3.6.10.in-addr.arpa
mkdir -p /etc/bind/jarkom
mkdir /etc/bind/vitamin
cp /etc/bind/db.local /etc/bind/vitamin/vitamin.brokoli.a05.com

cp /etc/bind/db.local /etc/bind/jarkom/pokcoy.a05.com

# CP

# NOMOR 2 :

echo 'zone "bayam.a05.com" {
  type master;
  file "/etc/bind/jarkom/bayam.a05.com";
};

zone "brokoli.a05.com" {
    type master;
    file "/etc/bind/jarkom/brokoli.a05.com";
};

zone "buncis.a05.com" {
    type master;
    file "/etc/bind/jarkom/buncis.a05.com";
}; ' >/etc/bind/named.conf.local

echo '
$TTL    604800
@       IN      SOA     bayam.a05.com. root.bayam.a05.com. (
                          2         ; Serial
                    604800         ; Refresh
                      86400         ; Retry
                    2419200         ; Expire
                    604800 )       ; Negative Cache TTL
;
@       IN      NS      bayam.a05.com.
@       IN      A       10.6.1.3 ' >/etc/bind/jarkom/bayam.a05.com

echo ' 
$TTL    604800
@       IN      SOA     brokoli.a05.com. root.brokoli.a05.com. (
                          2         ; Serial
                    604800         ; Refresh
                      86400         ; Retry
                    2419200         ; Expire
                    604800 )       ; Negative Cache TTL
;
@       IN      NS      brokoli.a05.com.
@       IN      A       10.6.3.3 ' >/etc/bind/jarkom/brokoli.a05.com

echo '
$TTL    604800
@       IN      SOA     buncis.a05.com. root.buncis.a05.com. (
                          2         ; Serial
                    604800         ; Refresh
                      86400         ; Retry
                    2419200         ; Expire
                    604800 )       ; Negative Cache TTL
;
@       IN      NS      buncis.a05.com.
@       IN      A       10.6.2.2 ' >/etc/bind/jarkom/buncis.a05.com
service bind9 restart

# ini di client
# nameserver 10.6.2.3
# ping bayam.a05.com -c 3
# ping brokoli.a05.com -c 3
# ping buncis.a05.com -c 3

# NOMOR 3

echo 'zone "bayam.a05.com" {
  type master;
  file "/etc/bind/jarkom/bayam.a05.com";
};

zone "brokoli.a05.com" {
    type master;
    file "/etc/bind/jarkom/brokoli.a05.com";
};

zone "buncis.a05.com" {
    type master;
    file "/etc/bind/jarkom/buncis.a05.com";
}; ' >/etc/bind/named.conf.local

echo '
$TTL    604800
@       IN      SOA     bayam.a05.com. root.bayam.a05.com. (
                          2         ; Serial
                    604800         ; Refresh
                      86400         ; Retry
                    2419200         ; Expire
                    604800 )       ; Negative Cache TTL
;
@       IN      NS      bayam.a05.com.
@       IN      A       10.6.1.3
www     IN      CNAME   bayam.a05.com. ' >/etc/bind/jarkom/bayam.a05.com

echo ' 
$TTL    604800
@       IN      SOA     brokoli.a05.com. root.brokoli.a05.com. (
                          2         ; Serial
                    604800         ; Refresh
                      86400         ; Retry
                    2419200         ; Expire
                    604800 )       ; Negative Cache TTL
;
@       IN      NS      brokoli.a05.com.
@       IN      A       10.6.3.3 
www     IN      CNAME   brokoli.a05.com.' >/etc/bind/jarkom/brokoli.a05.com

echo '
$TTL    604800
@       IN      SOA     buncis.a05.com. root.buncis.a05.com. (
                          2         ; Serial
                    604800         ; Refresh
                      86400         ; Retry
                    2419200         ; Expire
                    604800 )       ; Negative Cache TTL
;
@       IN      NS      buncis.a05.com.
@       IN      A       10.6.2.2 
www     IN      CNAME   buncis.a05.com.' >/etc/bind/jarkom/buncis.a05.com

service bind9 restart

# ini di client
# nameserver 10.6.2.3
# ping bayam.a05.com -c 3
# ping brokoli.a05.com -c 3
# ping buncis.a05.com -c 3

# NOMOR 4

echo '
zone "1.6.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/1.6.10.in-addr.arpa";
};

zone "2.6.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/2.6.10.in-addr.arpa";
};

zone "3.6.10.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/3.6.10.in-addr.arpa";
};
' >>/etc/bind/named.conf.local

echo '
$TTL 604800
@    IN    SOA    reverse1.a05.com. root.reverse1.a05.com. (
        2024100101 ; Serial
        7200       ; Refresh
        1800       ; Retry
        1209600    ; Expire
        43200 )    ; Negative Cache TTL
;
1.6.10.in-addr.arpa.   IN    NS    reverse1.a05.com.
3                      IN    PTR   bayam.a05.com.
' >/etc/bind/jarkom/1.6.10.in-addr.arpa

echo '
$TTL 604800
@    IN    SOA    reverse2.a05.com. root.reverse2.a05.com. (
        2024100101 ; Serial
        7200       ; Refresh
        1800       ; Retry
        1209600    ; Expire
        43200 )    ; Negative Cache TTL
;
2.6.10.in-addr.arpa.   IN    NS    reverse2.a05.com.
2                      IN    PTR   buncis.a05.com.
' >/etc/bind/jarkom/2.6.10.in-addr.arpa

echo '
$TTL 604800
@    IN    SOA    reverse3.a05.com. root.reverse3.a05.com. (
        2024100101 ; Serial
        7200       ; Refresh
        1800       ; Retry
        1209600    ; Expire
        43200 )    ; Negative Cache TTL
;
3.6.10.in-addr.arpa.   IN    NS    reverse3.a05.com.
3                      IN    PTR   brokoli.a05.com.
' >/etc/bind/jarkom/3.6.10.in-addr.arpa

service bind9 restart

# di client
# # Pengujian:
# host -t PTR 10.6.3.3
# host -t PTR 10.6.2.2

# NOMOR 5

echo '
$TTL    604800
@       IN      SOA     bayam.A05.com. root.bayam.A05.com. (
                        2024100105   ; Serial (YYYYMMDD + NOMOR KELOMPOK)
                        7200         ; Refresh (2 hours)
                        1800         ; Retry (30 minutes)
                        1209600      ; Expire (2 weeks)
                        43200        ; Minimum TTL (12 hours)

@       IN      NS      bayam.A05.com.
@       IN      A       10.6.1.3       ; IP Bayam
www     IN      CNAME   bayam.A05.com.' >/etc/bind/jarkom/bayam.A05.com

# NOMOR 6

echo -e '
zone "1.6.10.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/1.6.10.in-addr.arpa";
};
zone "2.6.10.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/2.6.10.in-addr.arpa";
};
zone "3.6.10.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/3.6.10.in-addr.arpa";
};

zone "bayam.a05.com" {
    type master;
    notify yes;
    also-notify { 10.6.4.2; };
    allow-transfer { 10.6.4.2; };
    file "/etc/bind/jarkom/bayam.a05.com";
};

zone "brokoli.a05.com" {
    type master;
    notify yes;
    also-notify { 10.6.4.2; };
    allow-transfer { 10.6.4.2; };
    file "/etc/bind/jarkom/brokoli.a05.com";
};

zone "buncis.a05.com" {
    type master;
    notify yes;
    also-notify { 10.6.4.2; };
    allow-transfer { 10.6.4.2; };
    file "/etc/bind/jarkom/buncis.a05.com";
};

zone "pokcoy.a05.com" {
    type master;
    notify yes;
    also-notify { 10.6.4.2; };
    allow-transfer { 10.6.4.2; };
    file "/etc/bind/jarkom/pokcoy.a05.com";
};

' >/etc/bind/named.conf.local

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     pokcoy.a05.com. root.pokcoy.a05.com. (
                        2024100105    ; Serial
                         7200         ; Refresh
                          1800        ; Retry
                        1209600       ; Expire
                         43200)       ; Negative Cache TTL;
;
@       IN      NS      pokcoy.a05.com.
@       IN      A       10.6.4.2       ; IP Pokcoy
www     IN      CNAME   pokcoy.a05.com. ;
' > /etc/bind/jarkom/pokcoy.a05.com

# NOMOR 7

echo '
$TTL    604800
@       IN      SOA     brokoli.a05.com. root.brokoli.a05.com. (
                        2024100106    ; Serial (update ini setiap kali ada perubahan)
                         7200         ; Refresh
                          1800        ; Retry
                        1209600       ; Expire
                         43200 )      ; Negative Cache TTL
;
@       IN      NS      brokoli.a05.com.
@       IN      A       10.6.3.3       ; IP Brokoli

www     IN      CNAME   brokoli.a05.com.  ; Alias untuk brokoli.a05.com
vitamin IN      A       10.6.4.2       ; IP Pokcoy
ns1     IN      A       10.6.4.2       ; NS record pointing to ns1
vitamin IN      NS      ns1            ; Nameserver untuk vitamin.brokoli.a05.com
' > /etc/bind/jarkom/brokoli.a05.com




echo "options {
    directory \"/var/cache/bind\";
    allow-query { any; };
    auth-nxdomain no;
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options


echo '
zone "vitamin.brokoli.a05.com" {
    type master;
    notify yes;
    also-notify { 10.6.4.2; };
    allow-transfer { 10.6.4.2; };
    file "/etc/bind/vitamin/vitamin.brokoli.a05.com";
};
' >> /etc/bind/named.conf.local

# NOMOR 8 DI DNS SLAVE