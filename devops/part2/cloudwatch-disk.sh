#!/bin/bash

apt-get install libwww-perl libdatetime-perl unzip

cd /opt/

#curl -O https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip

#wget http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip

curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O

unzip CloudWatchMonitoringScripts-1.2.2.zip && \
rm CloudWatchMonitoringScripts-1.2.2.zip && \
cd aws-scripts-mon

cp awscreds.template awscreds.conf

# NEED TO ADD CREDS
echo ** ADD CREDS !!!! **

echo ** ADD CRON JOB **
echo "Create/edit: crontab -e"
echo "View: crontab -l"
echo "*/5 * * * * /home/ubuntu/aws-scripts-mon/mon-put-instance-data.pl --disk-space-util --disk-path=/ --from-cron"

echo "If error, writes error message in /var/log/syslog"





# If want to bypass crontab for later fun...
# cat >/etc/cron.d/cloudwatch-monitor<<EOF
# */5 * * * * root /home/ubuntu/aws-scripts-mon/mon-put-instance-data.pl --disk-space-util --disk-path=/
# chmod +x /etc/cron.d/cloudwatch-monitor
# /etc/init.d/cron restart
# EOF