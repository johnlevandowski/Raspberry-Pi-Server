# logwatch

## Install logwatch
~~~
sudo apt install logwatch -y
sudo mkdir /var/cache/logwatch
~~~

## Configure Logwatch
~~~
LOGWATCHCONF="/etc/logwatch/conf/logwatch.conf"
echo 'Output = mail' | sudo tee $LOGWATCHCONF > /dev/null
echo 'MailTo = root' | sudo tee -a $LOGWATCHCONF > /dev/null
echo 'Detail = High' | sudo tee -a $LOGWATCHCONF > /dev/null
cat $LOGWATCHCONF
~~~
