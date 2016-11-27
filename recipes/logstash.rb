### logstash config
## Get IP address on ETH1 for vagrant box
ip = node['network']['interfaces']['enp0s8']['addresses'].detect{|k,v| v['family'] == "inet" }.first


execute 'apt-get-update-logstash' do
  command 'apt-get update'
  action :nothing
  notifies :install, "apt_package[logstash]", :delayed
end

remote_file '/root/GPG-KEY-elasticsearch' do
  source 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch'
  owner 'root'
  group 'root'
  checksum '10e406ba504706f44fbfa57a8daba5cec2678b31c1722e262ebecb5102d07659'
  notifies :run, "execute[add_key]"
end

execute 'add_key' do
  command 'apt-key add /root/GPG-KEY-elasticsearch'
  action :nothing
  notifies :run, "execute[apt-get-update-logstash]"
end

cookbook_file '/etc/apt/sources.list.d/logstash.list' do
  source 'logstash.list'
  owner 'root'
  group 'root'
  mode 00644
  # notifies :run, "execute[repo_key]"
end

apt_package 'logstash' do
  action :nothing
  ignore_failure true
end

template '/etc/logstash/conf.d/01-ossec-singlehost.conf' do
  source '01-ossec-singlehost.conf.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables({
            "remote_host" => ip
           })
  notifies :restart, "service[logstash]"
end

cookbook_file '/etc/logstash/elastic-ossec-template.json' do
  source 'elastic-ossec-template.json'
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, "service[logstash]"
end

# TODO: add template to ?

# geolitecity_dat = Chef::Config[:file_cache_path] + '/GeoLiteCity.dat.gz'
#
# remote_file geolitecity_dat do
remote_file '/root/GeoLiteCity.dat.gz' do
  source 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'
  owner 'root'
  group 'root'
  checksum '561ff6d6ac149e5556d95a2733e47d53035b68e68f235050d0a6354ee98b48a0'
end

execute 'extract_GeoLiteCity_dat' do
  command 'gzip -d /root/GeoLiteCity.dat.gz && mv /root/GeoLiteCity.dat /etc/logstash/'
  action :run
  creates '/etc/logstash/GeoLiteCity.dat'
end

#  TODO: fix this failure
# group ossec do
#   action :modify
#   members "logstash"
#   append true
#   ignore_failure true
# end


service 'logstash' do
  supports :status => true
  action [ :enable, :start ]
  ignore_failure true
end

# TODO:
# In single-host deployments, you also need to grant the logstash user access to OSSEC alerts file:
# sudo usermod -a -G ossec logstash

# install geoip stuff ??
# $ sudo curl -O "http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz"
# $ sudo gzip -d GeoLiteCity.dat.gz && sudo mv GeoLiteCity.dat /etc/logstash/
