YeepaySite Site Server Dockerized and Clusted example
================

### Yeepay Site Server Docker file
----
##### Dockerfile
```dockerfile
#################################################### 
# For Node.js (www.yeepay.com) 
####################################################
 
FROM yeepay/nodejs-base
MAINTAINER lidawei dawei.li@yeepay.com

RUN mkdir /usr/local/yeepay-site
RUN mkdir /usr/local/yeepay-site/output
ADD yeepay-site /usr/local/yeepay-site

EXPOSE 8080
ENTRYPOINT ["/usr/bin/node", "/usr/local/yeepay-site/yeepay-site.js"]
```

##### Build the docker images
```bash
docker build -t yeepay/yeepay-site:latest .
```

##### Install a volume by NFS which contain yeepay's images 
```bash
docker run -d --restart=always --name yeepay-site-server  -v /mnt/nfs/yeepay-site/logs:/tmp --privileged=true yeepay/docker-nfs-server /tmp
```
[Download]("nfs-yeepay-site.bash")

##### Get the ip address of the docker container
```bash
docker inspect yeepay-site-server | grep IPAddress
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

Use Yeepay Site Server in K8s Cluster
-------------------------

### Deploy Yeepay Site Server

##### Edit yeepay-site-server-controller.yaml
```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: yeepay-site
  labels:
    name: yeepay-site
spec:
  replicas: 2
  selector:
    name: yeepay-site
  template:
    metadata:
      labels:
        name: yeepay-site
    spec:
      containers:
      - name: yeepay-site
        image: registry.docker.yeepay.com:5000/yeepay/yeepay-site:v1.0.0
        ports:
        - containerPort: 8080
```
[Download]("yeepay-site-server-controller.yaml")

#####  Create yeepay-site-server-controller.yaml
```bash
kubectl create -f yeepay-site-server-controller.yaml

kubectl get rc,pods
CONTROLLER   CONTAINER(S)   IMAGE(S)            SELECTOR          REPLICAS
yeepay-site   master         yeepay/yeepay-site  name=yeepay-site  2

NAME               READY     STATUS    RESTARTS   AGE
yeepay-site-7yhr7   1/1       Running   1          1h
yeepay-site-8k8vf   1/1       Running   1          1h
```

##### Edit the yeepay-site-server-service.yaml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: yeepay-site
  labels:
    name: yeepay-site
spec:
  ports:
    # the port that this service should serve on
  - port: 8080
    targetPort: 8080
    protocol: TCP
    nodePort: 32766
  type: "NodePort"
  selector:
    name: yeepay-site
```
[Download]("yeepay-site-server-service.yaml")

##### Create the yeepay-site-server-service
```bash
kubectl create -f yeepay-site-server-service.yaml

NAME         LABELS                                    SELECTOR          IP(S)           PORT(S)
yeepay-site  name=yeepay-site                          name=yeepay-site  192.168.3.108   8080/TCP
```

##### Test the yeepay-site-server-service
```bash
curl 192.168.3.108:8080
Empty reply from server
```

### Yeah!~~~~~
