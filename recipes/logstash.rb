### logstash config

# cookbook_file '/opt/logstash/server/etc/conf.d/01-ossec-singlehost.conf' do
#   source '01-ossec-singlehost.conf'
#   owner 'logstash'
#   group 'logstash'
#   mode 00755
# end
#
# cookbook_file '/opt/logstash/server/etc/elastic-ossec-template.json' do
#   source 'elastic-ossec-template.json'
#   owner 'logstash'
#   group 'logstash'
#   mode 00755
# end



# execute 'apt-get-update-logstash' do
#   command 'apt-get update'
#   action :nothing
#   notifies :install, "apt_package[logstash]", :delayed
# end
#
# execute 'repo_key' do
#   command 'wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -'
#   action :nothing
#   notifies :run, "execute[apt-get-update-logstash]"
# end
#
# cookbook_file '/etc/apt/sources.list.d/logstash.list' do
#   source 'logstash.list'
#   owner 'root'
#   group 'root'
#   mode 00644
#   notifies :run, "execute[repo_key]"
# end
#
# apt_package 'logstash' do
#   action :nothing
#   ignore_failure true
# end
#
#
# service 'logstash' do
#   supports :status => true
#   action [ :enable, :start ]
#   ignore_failure true
# end
#
# cookbook_file '/etc/logstash/conf.d/01-ossec-singlehost.conf' do
#   source '01-ossec-singlehost.conf'
#   owner 'root'
#   group 'root'
#   mode 00644
#   notifies :restart, "service[logstash]"
# end
#
# cookbook_file '/etc/logstash/elastic-ossec-template.json' do
#   source 'elastic-ossec-template.json'
#   owner 'root'
#   group 'root'
#   mode 00644
#   notifies :restart, "service[logstash]"
# end
