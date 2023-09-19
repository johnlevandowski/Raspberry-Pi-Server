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
echo 'inet_protocols = ipv4' | sudo tee -a $POSTFIXCONF > /dev/null
tail -n 8 $POSTFIXCONF
echo ""

echo "# Forward root email"
MAILALIAS="/etc/aliases"
echo '' | sudo tee -a $MAILALIAS > /dev/null
echo 'pi: john' | sudo tee -a $MAILALIAS > /dev/null
echo 'root: john' | sudo tee -a $MAILALIAS > /dev/null
echo 'john: john' | sudo tee -a $MAILALIAS > /dev/null
cat $MAILALIAS
echo "~~~"
echo "sudo nano /etc/aliases"
echo "~~~"
echo "update john alias destination to gmail email address so forwarded gmail is auto deleted from sent folder"
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
echo "sudo chown root:root /etc/postfix/sasl/*"
echo "sudo chmod 0600 /etc/postfix/sasl/*"
echo "~~~"
echo "sudo postfix check"
echo "correct duplicate errors"
echo "~~~"
echo "sudo systemctl restart postfix"
echo "~~~"
echo ""
