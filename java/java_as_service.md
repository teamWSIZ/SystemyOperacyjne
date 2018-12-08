### Uruchomienie aplikacji Javy jako serwisu (pod linuxem)

Notka: https://stackoverflow.com/questions/21503883/spring-boot-application-as-a-service/22121547

1. zbudować jar-a (mvn package)

1. skopiować gdzieś (np. do `/opt/own`)

1. stworzyć serwis do systemd, w `/etc/systemd/system` zrobić plik 
`javaexec.service` :
```
[Unit]
Description= Java exec system

[Service]
User=nobody
WorkingDirectory=/opt/own
ExecStart=/usr/bin/java -Xmx512m -jar exec.jar
SuccessExitStatus=143
TimeoutStopSec=10
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```
1. przeładować systemd, `systemctl daemon-reload`
1. start: `systemctl start javaexec`
1. `status`, `stop` etc działają
1. załączenie przy starcie: `systemctl enable javaexec`
1. logi: `journalctl -u javaexec`
