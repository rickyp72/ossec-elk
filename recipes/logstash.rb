### logstash config

execute 'apt-get-update-logstash' do
  command 'apt-get update'
  action :nothing
  notifies :install, "apt_package[logstash]", :delayed
end

elastic_repo = Chef::Config[:file_cache_path] + '/GPG-KEY-elasticsearch'

remote_file elastic_repo do
  source 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch'
  owner 'root'
  group 'root'
  checksum '10e406ba504706f44fbfa57a8daba5cec2678b31c1722e262ebecb5102d07659'
end

execute 'add_key' do
  command 'apt-key add GPG-KEY-elasticsearch'
  action :run
  notifies :run, "execute[apt-get-update-logstash]"
end

# execute 'repo_key' do
#   command 'wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -'
#   action :nothing
#   notifies :run, "execute[apt-get-update-logstash]"
# end

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


cookbook_file '/etc/logstash/conf.d/01-ossec-singlehost.conf' do
  source '01-ossec-singlehost.conf'
  owner 'root'
  group 'root'
  mode 00644
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

geolitecity_dat = Chef::Config[:file_cache_path] + '/GeoLiteCity.dat.gz'

remote_file geolitecity_dat do
  source 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'
  owner 'root'
  group 'root'
  checksum '561ff6d6ac149e5556d95a2733e47d53035b68e68f235050d0a6354ee98b48a0'
end

execute 'extract_GeoLiteCity_dat' do
  command 'gzip -d GeoLiteCity.dat.gz && mv GeoLiteCity.dat /etc/logstash/'
  action :run
end

group ossec do
  action :modify
  members "logstash"
  append true
end

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
