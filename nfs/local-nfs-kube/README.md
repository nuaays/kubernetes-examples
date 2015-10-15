Kubernetes NFS Server Example Use Local NFS Server
================

Expose a NFS Server with docker
----
##### Use docker-nfs-server as a nfs-server 
##### Expose a shared directory witch contect the nfs-data-device use docker -v options
##### U should notice the --privileged=true option, its' required
```bash
docker run -d --restart=always --name nfs-server -v /mnt/nfs/:/tmp --privileged=true yeepay/docker-nfs-server /tmp
```

##### Get the IPAdress of nfs-server
```bash
docker inspect nfs-server | grep IPAdress

"IPAddress": "172.17.0.1",
"SecondaryIPAddresses": null,
```

##### Install nfs-common on your host machine, then test
```bash
showmount -e 172.17.0.1

Export list for 172.17.0.1:
/tmp *

```
##### Test nfs mount
```bash 
mkdir /nfs
mount -t nfs 172.17.0.1:/tmp /nfs
umount /nfs
rm -fr /nfs
```

Use NFS Server in K8s Cluster
-------------------------

### Note: You expose the 172.17.0.1:/tmp derectory as a nfs-mount-point, so, in k8s pods, you should mount the /tmp as the mount point


##### Write the index.html for test
```bash
cat > /mnt/nfs/index.html

Hello world!
```

##### Test the NFS Server with nginx 
```bash
cat > nfs-web-pod.yaml
#
# This pod imports nfs-server.default.kube.local:/ into /usr/share/nginx/html
#

apiVersion: v1
kind: Pod
metadata:
  name: nfs-web-local
spec:
  containers:
    - name: web
      image: nginx
      ports:
        - name: web
          containerPort: 80
      volumeMounts:
          # name must match the volume name below
          - name: nfs
            mountPath: "/usr/share/nginx/html"
  volumes:
    - name: nfs
      nfs:
        # FIXME: use the right hostname
        # server: nfs-server.default.cluster.local
        server: 172.17.0.1
        path: "/tmp" #!!!!!!!!

```

##### Create the testing pod
```bash
kubectl create -f nfs-web-pod.yaml

kubectl get pods nfs-web-local

kubectl describe pods nfs-web-local | grep IP
IP:				172.17.0.8
```

##### Test the nginx service
```bash
curl 172.17.0.8/
Hello world!
```

