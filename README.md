# Sweet Dashboard Project (an OSE Ruby s2i codebase)

This project is a base setup for dashing on OSE.  Please see the local [dashing-ose-template.yaml](https://github.com/welshstew/sweet-dashboard-project/blob/master/dashing-ose-template.yaml) to see how to get this building/running in OSE.

As per the [Getting Started](http://dashing.io/)

```
gem install dashing
dashing new sweet_dashboard_project
bundle
```

## Installing on Openshift...

```
OSE_REGISTRY=`oc get svc/docker-registry -n default -o json | jq -r  '[.spec.clusterIP,.spec.ports[0].port|tostring] | join(":")'`
IS_PULL_NAMESPACE=origin-metrics
oc create -f dashing-ose-template.yaml
oc new-app --template=dashing -pIS_PULL_NAMESPACE=$IS_PULL_NAMESPACE,REGISTRY=$OSE_REGISTRY
```

## Table Widget - displays pods

The table widget is configured to call the Kubernetes API and grab

## Queue Count Widget - grab data from hawkular...

```
curl 'https://hawkular-metrics-origin-metrics.rhel-cdk.10.1.2.2.xip.io/hawkular/metrics/gauges/raw/query' -H 'Hawkular-Tenant: origin-metrics' -H 'Origin: http://grafana-service-origin-metrics.rhel-cdk.10.1.2.2.xip.io' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.8' -H 'Authorization: Bearer Zk6uP-N5clDdNv4p8K-_MTWVtw-yzU90h9guls8IXfE' -H 'Content-Type: application/json' -H 'Accept: application/json, text/plain, */*' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36' -H 'Referer: http://grafana-service-origin-metrics.rhel-cdk.10.1.2.2.xip.io/dashboard/db/new-dashboard?panelId=2&fullscreen&edit&editorTab=Metrics' -H 'Connection: keep-alive' --data-binary '{"ids":["amq.broker-amq-1.queue.one.QueueSize"],"start":1472921170425,"end":1472921470425}' --compressed --insecure
[{"id":"amq.broker-amq-1.queue.one.QueueSize","data":[{"timestamp":1472921432000,"value":0.0},{"timestamp":1472921407000,"value":0.0},{"timestamp":1472921372000,"value":0.0},{"timestamp":1472921347000,"value":0.0},{"timestamp":1472921312000,"value":0.0},{"timestamp":1472921287000,"value":0.0},{"timestamp":1472921252000,"value":0.0}]}]
```


## Links

Check out http://shopify.github.com/dashing for more information.