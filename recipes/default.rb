#
# Cookbook Name:: ossec-elk
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


include_recipe 'java::oracle'
include_recipe 'ossec-elk::wazuh_ossec'
include_recipe 'ossec-elk::logstash'
include_recipe 'ossec-elk::elasticsearch'


# sudo curl -O "http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz"
# sudo gzip -d GeoLiteCity.dat.gz && sudo mv GeoLiteCity.dat /etc/logstash/
# sudo usermod -a -G ossec logstash
