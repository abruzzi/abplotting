#!/bin/bash


ab -n 1000 -c 20 -g single-mapserver-instance-n1000-c20.data "http://192.168.3.11/cgi-bin/mapserv?map=/data/pg-xian-wfs.map&layer=highways&SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TypeName=highways&SRSNAME=EPSG:4326&MAXFEATURES=10&propertyName=name,highway"

ab -n 1000 -c 20 -g squid-with-2-mapserver-instances-n1000-c20.data "http://192.168.3.15/cgi-bin/mapserv?map=/data/pg-xian-wfs.map&layer=highways&SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TypeName=highways&SRSNAME=EPSG:4326&MAXFEATURES=10&propertyName=name,highway"


gnuplot plot-script.g
