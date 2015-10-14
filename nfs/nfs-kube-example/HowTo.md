Kubernetes NFS Server Example
================

Usage
----
##### Modfiy kube-apiserver and kubelet config add --allow-privileged=true and restart kube-apiserver and kubelet

##### Set SeLinux Disabled!!!

```bash
kubectl create -f nfs-server-pod.yaml
kubectl create -f nfs-server-service.yaml

```

##### Get nfs-service Endpoint
```bash
kubectl get svc | grep nfs-server

```
##### eg. nfs-service: 192.168.3.194
##### Replace the nfs-server.default.cluster.local in nfs-web-pod.yaml with 192.168.3.194

```bash
kubectl create -f nfs-web-pod.yaml

```

Demo
====================
```bash
kubectl get pods
NAME         READY     STATUS    RESTARTS   AGE
busybox      1/1       Running   0          1h
nfs-server   1/1       Running   1          2h
nfs-web      1/1       Running   0          1h

```

```bash
	kubectl get svc
NAME         LABELS                                    SELECTOR          IP(S)           PORT(S)
	nfs-server   <none>                                    role=nfs-server   192.168.3.194   2049/TCP
```

##### Change nfs-web-pod.yaml
```bash
cat nfs-web-pod.yaml

#
# This pod imports nfs-server.default.kube.local:/ into /usr/share/nginx/html
#

apiVersion: v1
kind: Pod
metadata:
  name: nfs-web
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
        server: 192.168.3.194
        path: "/"

```

```bash
kubectl describe pods nfs-web

Name:				nfs-web
Namespace:			default
Image(s):			nginx
Node:				192.168.162.167/192.168.162.167
Labels:				<none>
Status:				Running
Reason:				
Message:			
IP:				172.17.0.8
Replication Controllers:	<none>
Containers:
  web:
  Image:		nginx
  State:		Running
  Started:		Wed, 14 Oct 2015 00:13:20 -0700
  Ready:		True
  Restart Count:	0
  Conditions:
  Type		Status
  Ready 	True 
  No events.
```


Test
=============================

```bash
curl  172.17.0.8/

Hello world!
```
