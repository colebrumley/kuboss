FROM elcolio/supervisor:latest

# Add executables & configs
RUN mkdir /exe
ADD executables/* /exe/
ADD supervisor-configs/* /etc/supervisor/conf.d/
ENV PATH $PATH:/exe
EXPOSE 8443 7080 8080

# api server defaults, override @ CLI
ENV KUBE_ETCD_SERVERS http://127.0.0.1:4001
ENV KUBE_API_ADDRESS 0.0.0.0
ENV KUBE_API_PORT 8080
ENV PORTAL_NET 10.254.0.0/16
