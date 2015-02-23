# Kuboss
**A Kubernetes Master node in a Docker container.**  Why?  If you don't need a dedicated Master VM and you don't want to risk redundancy by running Master services on a Minion node, this container allows you to run a self-contained, dedicated Master from anywhere.

My initial use case was running several 2 node Kube clusters (they had to be distinct).  I didn't want one of the nodes to run both Master and Minion services since that kinda kills the whole redundancy thing, and I needed at least one more node for Etcd to achieve a quorum.  My solution is to run Etcd and the Kube Master services in containers on a remote host.

Using Systemd units (or another Kube cluster), I can maintain uptime on the master services while still removing them from the machines doing the grunt work in the cluster.

##Usage
Usage is pretty straightforward.  There are `ENV` variables that determine where Etcd is, what addresses to bind to, and what flags to pass the Kube services.

This container is meant to bind to 0.0.0.0, **not** expose ports, and use Flanneld or another network overlay to achieve connectivity.

For testing, I spun up an instance of `elcolio/etcd` and got it's IP using `docker inspect -f '{{.NetworkSettings.IPAddress}}' etcd`:
```sh
docker run -d --name kube -e KUBE_ETCD_SERVERS=http://172.17.0.49:4001 elcolio/kuboss
```
In addition to the ENVs mentioned in the Dockerfile, the container can also use:
  - API_ARGS
  - CONTROLLER_MANAGER_ARGS
  - SCHEDULER_ARGS
  - KUBELET_ADDRESSES
