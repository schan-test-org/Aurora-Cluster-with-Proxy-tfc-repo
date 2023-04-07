# PostgreSQL Cluster & RDS Proxy

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

