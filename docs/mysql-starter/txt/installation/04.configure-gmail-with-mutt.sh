# install the following first 
apt-get install -y libc6
apt-get install -y openssl 
apt-get install -y libsasl2-2 libsasl2-modules
apt-get install -y postfix 
apt-get install -y sendmail 
apt-get install -y ca-certificates 
apt-get install -y mutt

# copy the example configuration file .muttrc to your user profile 
cp -v conf/hosts/ysg-host-name/home/usrmysql-starter/.muttrc /home/usrmysql-starter/.muttrc

# should a mutt cal fail troubleshoot by calling it with debugging :
mutt -n -d 3

# and check the ~/.muttdebug<<n>> after the failure ... 
