###  after-checking ###
```
kubectl run -it --image nicolaka/netshoot testnet bash
telnet <rds-endpoint> <rds-port>
telnet <rds-proxy> <rds-port>


kubectl run -it --image bitnami/postgresql psg bash
psql --host=<rds-proxy> \
   --port=5432 \
   --username=<psg-root-name> \
   --dbname=<psg-db-name>

 ```

pw 관련 정보는 tfc 콘솔상에 terraform var 로 기재
