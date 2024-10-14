apt-get update
apt-get install dnsutils -y

echo -e '
nameserver 10.6.2.3 
nameserver 10.6.4.2 
nameserver 192.168.122.1
' > /etc/resolv.conf


# IP SEBAGAI CATATAN

# Tomat client -> 10.6.1.2
# BayamWebServer -> 10.6.1.3
# BuncisWebServer -> 10.6.2.2
# WortelDNSMaster -> 10.6.2.3
# TaugeClient -> 10.6.3.2
# BrokoliWebServer -> 10.6.3.3
# PokcoyDNSSlave -> 10.6.4.2


# DNS END 




#  UNTUK BROKOLI INI DI NOMER 9 SAMPAI 20 tidak bisa langsung bashrc, harus dijalankan satu persatu karena ada kombinasi restart dan stop service
# WEB SERVER START


apt-get update                                                             
apt-get install nginx -y                                                 
apt-get install lynx -y

