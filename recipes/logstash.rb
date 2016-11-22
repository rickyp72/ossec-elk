### logstash config

execute 'repo_key' do
  command 'wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -'
  action :nothing
end

cookbook_file '/etc/apt/sources.list.d/logstash.list' do
  source 'logstash.list'
  owner 'root'
  group 'root'
  mode 00644
  notifies :run, "execute[repo_key]"
end

service 'logstash' do
  supports :status => true
  action [ :enable, :start ]
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
