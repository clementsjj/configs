-   Show Python script in Lambda
-   Run `pythonCloudWatchTerminate` Test
-   Run `pythonCloudWatchLaunch` Test
    -   This will run the python script which will run the `put_metric_alarm()` function which creates a new alarm.
-   Create big files
    -   Could maybe create two files and wait a little bit to see it increase
    -   In anne01, run `fallocate -l 2G bigfile1`
-   Should trigger an alarm

put_metric_alarm
kind of hard to find the correct format, but after some trial and error, I broke it down into the proper format, mirroring what i had done earlier through the console.
Basically found a forum post with the aws cloudwatch cli script and patched that together
