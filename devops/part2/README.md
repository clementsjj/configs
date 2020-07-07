## Setup CloudWatch metric on DB node1

Reference: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html

-   Install Perl Scripts to monitor disk usage

    -   Run `cloudwatch-disk.sh`
        -   Downloads libwww-perl libdatetime-perl unzip
        -   Download AWS Monitoring Scripts; Unzip
        -   Create awscreds.conf
            -   Could store in s3 bucket, but hard coding from my own harddrive for now

-   Setup cronjob

    -   `crontab -e`
    -   `*/5 * * * * /home/ubuntu/aws-scripts-mon/mon-put-instance-data.pl --disk-space-util --disk-path=/ --from-cron`

cron job runs at `tail -f /var/log/syslog`
