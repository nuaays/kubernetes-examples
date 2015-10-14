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
