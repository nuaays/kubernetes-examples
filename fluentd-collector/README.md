Fluentd

```bash
docker build -t yeepay/fluentd-collector .
docker tag yeepay/fluentd-collector registry.docker.yeepay.com:5000/fluentd-collector
docker push registry.docker.yeepay.com:5000/fluentd-collector
```
