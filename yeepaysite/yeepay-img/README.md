YeepaySite Image Server Dockerized and Clusted example
================

### Image Server Docker file
----
##### Dockerfile
```dockerfile
#################################################### 
# For Node.js (www.yeepay.com) 
####################################################
 
FROM yeepay/nodejs-base
MAINTAINER lidawei dawei.li@yeepay.com

RUN mkdir /usr/local/yeepay-img
RUN mkdir /usr/local/yeepay-img/output
ADD yeepay-img /usr/local/yeepay-img

EXPOSE 8080
ENTRYPOINT ["/usr/bin/node", "/usr/local/yeepay-img/img-server.js"]
```

##### Build the docker images
```bash
docker build -t yeepay/img-server:latest .
```

##### Install a volume by NFS which contain yeepay's images 
```bash
docker run -d --restart=always --name yeepay-img-server  -v /mnt/yeepay/images/yeepay-img/public/:/tmp --privileged=true yeepay/docker-nfs-server /tmp
```
[Download]("nfs-yeepay-image.bash")

##### Get the ip address of the docker container
```bash
docker inspect yeepay-img-server | grep IPAddress
"IPAddress": "172.17.0.19"
```
##### Test the NFS server
```bash
showmount -e 172.17.0.19
Export list for 172.17.0.1:
/tmp *
```

##### Test nfs mount
```bash 
mkdir /nfs
mount -t nfs 172.17.0.19:/tmp /nfs
umount /nfs
rm -fr /nfs
```

Use Yeepay Image Server in K8s Cluster
-------------------------

### Deploy Yeepay Image Server

##### Edit yeepay-image-server-controller.yaml
```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: yeepay-img
  labels:
    name: yeepay-img
spec:
  replicas: 2
  selector:
    name: yeepay-img
  template:
    metadata:
      labels:
        name: yeepay-img
    spec:
      containers:
      - name: master
        image: yeepay/img-server
        ports:
        - containerPort: 8080
        volumeMounts:
        - name: nfs-yeepay-img
          mountPath: "/usr/local/yeepay-img/public"
      volumes:
        - name: nfs-yeepay-img
          server: 172.17.0.19
          path: "/tmp"
```
[Download]("yeepay-img-server-controller.yaml")

#####  Create yeepay-img-server-controller.yaml
```bash
kubectl create -f yeepay-img-server-controller.yaml

kubectl get rc,pods
CONTROLLER   CONTAINER(S)   IMAGE(S)            SELECTOR          REPLICAS
yeepay-img   master         yeepay/img-server   name=yeepay-img   2

NAME               READY     STATUS    RESTARTS   AGE
yeepay-img-7yhr7   1/1       Running   1          1h
yeepay-img-8k8vf   1/1       Running   1          1h
```

##### Edit the yeepay-img-server-service.yaml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: yeepay-img
  labels:
    name: yeepay-img
spec:
  ports:
    # the port that this service should serve on
  - port: 8080
    targetPort: 8080
  selector:
    name: yeepay-img
```
[Download]("yeepay-img-server-service.yaml")

##### Create the yeepay-img-server-service
```bash
kubectl create -f yeepay-img-server-service.yaml

NAME         LABELS                                    SELECTOR          IP(S)           PORT(S)
yeepay-img   name=yeepay-img                           name=yeepay-img   192.168.3.108   8080/TCP
```

##### Test the yeepay-img-server-service
```bash
curl 192.168.3.108:8080
Empty reply from server
```

### Yeah!~~~~~
