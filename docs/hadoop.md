# HADOOP

## Errors

Whenever you have errors in your mappers or reducers think about the below two possibilities.

### Take a look at the counters

Developers sometimes use them to tell about statistics related to code execution. 

### Take a look at the jobhistory server

Job History server usually listens at ports 8088 and 19888. 

Once you get to see your application through the job history server portal, you will get something like follows: 

```
http://hadoop:8088/proxy/application_xx_xx/mapreduce/job/job_xx_xx
```

From there you should take a look below, to the number telling the amount of Map Attempts that FAILED. Clicking it usually tells very low level information useful to determine why such mappers/reducers failed. 

```
http://hadoop:19888/jobhistory/attempts/job_xx_xx/m/FAILED
```
