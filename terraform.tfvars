projejctid = "pa-nteekens-2"
vpcname = "tanzu"
subnetname = "tanzu"
region = "europe-west4"
zone = "europe-west4-a"
subnetcidr = "10.10.0.0/16"
wgip = "192.168.15.1/32" #IP address for Wireguard server, be sure to add /32
clustername = "my-gke-cluster"
master_ipv4_cidr_block = "10.10.10.0/28"
cluster_ipv4_cidr_block  = "10.10.8.0/21"
services_ipv4_cidr_block = "10.10.16.0/21"
master_authorize_cidr = "10.10.0.0/16"
#jumphost_ip = "10.0.0.7"
#jumphost_name = "jumphost01"