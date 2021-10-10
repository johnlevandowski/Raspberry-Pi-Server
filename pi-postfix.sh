#!/bin/sh

echo "# Install Postfix - internet site"
sudo apt install postfix libsasl2-modules -y
sudo rm /etc/postfix/makedefs.out
sudo ln /usr/share/postfix/makedefs.out /etc/postfix/makedefs.out
sudo postfix check
echo ""

echo "# Configure Postfix"
POSTFIXCONF="/etc/postfix/main.cf"
echo '' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'relayhost = [smtp.gmail.com]:587' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'smtp_sasl_auth_enable = yes' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'smtp_tls_security_level = encrypt' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'smtp_sasl_security_options = noanonymous' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd' | sudo tee -a $POSTFIXCONF > /dev/null
echo 'smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt' | sudo tee -a $POSTFIXCONF > /dev/null
tail -n 8 $POSTFIXCONF
echo ""

echo "# Forward root email"
echo "~~~"
echo "sudo nano /etc/aliases"
echo "~~~"
echo "root: email address"
echo "john: email address"
echo "~~~"
echo "sudo newaliases"
echo "~~~"
echo ""

echo "# Configure Postfix Authentication"
echo "~~~"
echo "sudo nano /etc/postfix/sasl/sasl_passwd"
echo "~~~"
echo "[smtp.gmail.com]:587 username@gmail.com:password"
echo "~~~"
echo "sudo postmap /etc/postfix/sasl/sasl_passwd"
echo "sudo chmod 0600 /etc/postfix/sasl/*"
echo "~~~"
echo "sudo postfix check"
echo "correct duplicate errors"
echo "~~~"
echo "sudo systemctl restart postfix"
echo "~~~"
echo ""
