#!/bin/sh

echo "# Install Postfix - internet site"
sudo apt install postfix libsasl2-modules -y
sudo rm /etc/postfix/makedefs.out
sudo ln /usr/share/postfix/makedefs.out /etc/postfix/makedefs.out
sudo postfix check
echo ""

echo "# Configure Postfix"
echo "~~~"
echo "sudo nano /etc/postfix/sasl/sasl_passwd"
echo "~~~"
echo "[smtp.gmail.com]:587 username@gmail.com:password"
echo "~~~"
echo "sudo postmap /etc/postfix/sasl/sasl_passwd"
echo "sudo chmod 0600 /etc/postfix/sasl/*"
echo "~~~"
echo "sudo nano /etc/postfix/main.cf"
echo "~~~"
echo "relayhost = [smtp.gmail.com]:587"
echo "~~~"
echo "smtp_sasl_auth_enable = yes"
echo "smtp_tls_security_level = encrypt"
echo "smtp_sasl_security_options = noanonymous"
echo "smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd"
echo "smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt"
echo "~~~"
echo "sudo systemctl restart postfix"
echo "~~~"
echo ""
