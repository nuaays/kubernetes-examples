Docker NFS Server
================

Usage
----
```bash
docker run -d --name nfs --privileged cpuguy83/nfs-server /path/to/share /path/to/share2 /path/to/shareN
```

```bash
docker run -d --name nfs-client --privileged --link nfs:nfs cpuguy83/nfs-client /path/on/nfs/server:/path/on/client

```
Practice
----
```bash
docker run -d --name nfs-server -v /mnt/nfs:/tmp --privileged cpuguy83/nfs-server /tmp

```
```bash
docker inspect nfs-server | grep IP

```
```bash
showmount -e ${IP}

```
```bash
mount ${IP}:/tmp ${YourDir}


```
Thanks to cpuguy83
---

More Info
=========

See http://www.tech-d.net/2014/03/29/docker-quicktip-4-remote-volumes/
