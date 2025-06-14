# Postfix
## Install Postfix - internet site - rpi5.lan.johnl.dev
~~~
sudo apt install postfix libsasl2-modules mailutils -y
#sudo rm /etc/postfix/makedefs.out
#sudo ln /usr/share/postfix/makedefs.out /etc/postfix/makedefs.out
sudo postfix check
~~~

## Configure Postfix
~~~
POSTFIXCONF="/etc/postfix/main.cf"
echo '' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'relayhost = [smtp.gmail.com]:587' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'smtp_sasl_auth_enable = yes' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'smtp_tls_security_level = encrypt' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'smtp_sasl_security_options = noanonymous' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'inet_protocols = ipv4' | sudo tee -a $POSTFIXCONF > /dev/null
tail -n 8 $POSTFIXCONF
~~~

## Forward root email
~~~
MAILALIAS="/etc/aliases"
echo '' | sudo tee -a $MAILALIAS > /dev/null
echo 'root: john' | sudo tee -a $MAILALIAS > /dev/null
echo 'john: username@gmail.com' | sudo tee -a $MAILALIAS > /dev/null
cat $MAILALIAS
sudo newaliases
~~~

## Configure Postfix Authentication
~~~
sudo nano /etc/postfix/sasl/sasl_passwd
~~~

~~~
[smtp.gmail.com]:587 username@gmail.com:password
~~~

~~~
sudo postmap /etc/postfix/sasl/sasl_passwd
sudo chown root:root /etc/postfix/sasl/*
sudo chmod 0600 /etc/postfix/sasl/*
~~~

## correct duplicate errors
~~~
sudo postfix check
~~~

~~~
sudo systemctl restart postfix
echo "Test Postfix Gmail" | mail -s "Postfix Gmail" root
~~~
