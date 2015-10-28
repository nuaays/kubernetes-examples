YeepaySite Boss Server Dockerized and Clusted example
================

### Yeepay Boss Server Docker file
----
##### Dockerfile
```dockerfile
#################################################### 
# For Node.js (www.yeepay.com) 
####################################################
 
FROM yeepay/nodejs-base
MAINTAINER lidawei dawei.li@yeepay.com

RUN mkdir /usr/local/yeepay-boss
RUN mkdir /usr/local/yeepay-boss/output
ADD yeepay-boss /usr/local/yeepay-boss

EXPOSE 8080
ENTRYPOINT ["/usr/bin/node", "/usr/local/yeepay-boss/yeepay-boss.js"]
```

##### Build the docker images
```bash
docker build -t yeepay/yeepay-boss:latest .
```

##### Install a volume by NFS which contain yeepay's images 
```bash
docker run -d --restart=always --name yeepay-boss-server  -v /mnt/nfs/yeepay-boss/logs:/tmp --privileged=true yeepay/docker-nfs-server /tmp
```
[Download]("nfs-yeepay-boss.bash")

##### Get the ip address of the docker container
```bash
docker inspect yeepay-boss-server | grep IPAddress
"IPAddress": "172.17.0.20"
```
##### Test the NFS server
```bash
showmount -e 172.17.0.20
Export list for 172.17.0.1:
/tmp *
```

##### Test nfs mount
```bash 
mkdir /nfs
mount -t nfs 172.17.0.20:/tmp /nfs
umount /nfs
rm -fr /nfs
```

Use Yeepay Boss Server in K8s Cluster
-------------------------

### Deploy Yeepay Boss Server

##### Edit yeepay-boss-server-controller.yaml
```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: yeepay-boss
  labels:
    name: yeepay-boss
spec:
  replicas: 2
  selector:
    name: yeepay-boss
  template:
    metadata:
      labels:
        name: yeepay-boss
    spec:
      containers:
      - name: yeepay-boss
        image: registry.docker.yeepay.com:5000/yeepay/yeepay-boss:v1.0.0
        ports:
        - containerPort: 8080
```
[Download]("yeepay-boss-server-controller.yaml")

#####  Create yeepay-boss-server-controller.yaml
```bash
kubectl create -f yeepay-boss-server-controller.yaml

kubectl get rc,pods
CONTROLLER   CONTAINER(S)   IMAGE(S)            SELECTOR          REPLICAS
yeepay-boss   master         yeepay/yeepay-boss  name=yeepay-boss  2

NAME               READY     STATUS    RESTARTS   AGE
yeepay-boss-7yhr7   1/1       Running   1          1h
yeepay-boss-8k8vf   1/1       Running   1          1h
```

##### Edit the yeepay-boss-server-service.yaml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: yeepay-boss
  labels:
    name: yeepay-boss
spec:
  ports:
    # the port that this service should serve on
  - port: 8080
    targetPort: 8080
    protocol: TCP
    nodePort: 32766
  type: "NodePort"
  selector:
    name: yeepay-boss
```
[Download]("yeepay-boss-server-service.yaml")

##### Create the yeepay-boss-server-service
```bash
kubectl create -f yeepay-boss-server-service.yaml

NAME         LABELS                                    SELECTOR          IP(S)           PORT(S)
yeepay-boss  name=yeepay-boss                          name=yeepay-boss  192.168.3.108   8080/TCP
```

##### Test the yeepay-boss-server-service
```bash
curl 192.168.3.108:8080
Empty reply from server
```

### Yeah!~~~~~
