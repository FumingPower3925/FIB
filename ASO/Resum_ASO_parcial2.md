# SUMMARY ASO MIDTERM EXAM 2

## 1. Task Scheduling

### 1.1 crontab

- Periodic command execution.

- To schedule a command you need to modify the file /var/spool/cron/crontab/<user>, there's one for every user.

- Format for each comand line: mm HH DD MM DS = minute, hour, day of the month, month, day of the week. Example of command being executed every Tuesday at 12:33:
  
  `33 0 * * Tue <command>`

- The daemon is executed every minute, and it checks the crontab file --> no need to reload the daemon.

- Executed in user privileges.

### 1.2 at [-f <file>, -q queue] when

- Saved commands are stored in /var/spool/cron/atjobs

- Executed in user privileges.

### 1.3 Security considerations

- A disabled user can continue to execute commands using the cron or at commands, so we use these files:

        `/etc/{cron.allow, cron.deny, at.allow, at.deny}`

- If the .allow file exists, the user must be on it.

- If the .deny file exists, the user cannot be there.

## 2. Serveis de xarxa

### 2.1 Network admin considerations

There are different type of ports:

- Priviledged ports: 0 - 1023
  
  - Assigned by IANA
  
  - Only root users may install services to those ports.

- Registered ports: 1024 - 49151
  
  - Not controlled but registered by IANA.

- Dynamic ports: 49152 - 65535
  
  - 

The file `/etc/services` is a file that relates each service/daemon with the corresponding port number.
