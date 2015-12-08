##########################################################################
## Notes on firewall-cmd 
## Checked on CentOS7, Fedora21
##########################################################################


firewall-cmd --zone=public --list-ports         #also: --list-services
firewall-cmd --zone=public --add-port=5432/tcp
firewall-cmd --zone=public --add-port=5432/tcp --permanent
firewall-cmd --reload

firewall-cmd --get-active-zones         #zones with attached interfaces

#####################################
## Save everything as is now!
#####################################
firewall-cmd --runtime-to-permanent

## masquerade
## masquerade set on  zone _to which_ packets go (so: on WAN, not on the zone which is masqueraded (internal))
firewall-cmd --zone=internal --query-masquerade         #also add/remove

## forward ports
??

------------------
routing:
ip r add 10.2.1.0/24 via 10.1.1.2 dev p7p1

#####################################
# General:
#####################################
# Full printout of current configuration
firewall-cmd --list-all-zones

## Zones / Services / Interfaces
--get-all-services
--get-active-zones
--get-zones

firewall-cmd --zone=public --list-services
firewall-cmd --zone=public --list-interfaces
firewall-cmd --get-zone-of-interface enp0s3
firewall-cmd --get-zone-of-source=<source[/mask]>


###
## Q:
## -- list direct rules?
## --> AVOID USING DIRECT RULES !!!!

## Masquerade:
firewall-cmd --zone=public --query-masquerade
firewall-cmd --zone=public --add-masquerade

## Port forward && block ping etc:
http://www.tecmint.com/firewalld-rules-for-centos-7/2/
