### logstash config



apt_repository 'elasticsearch' do
  uri          'https://packages.elasticsearch.org/logstash/2.1/debian'
  arch         'amd64'
  distribution 'trusty'
  components   ['stable']
  key          'https://packages.elasticsearch.org/GPG-KEY-elasticsearch'
end

# service 'logstash_server' do
#   supports :status => true
#   action [ :enable, :start ]
# end
#
# cookbook_file '/etc/logstash/conf.d/01-ossec-singlehost.conf' do
#   source '01-ossec-singlehost.conf'
#   owner 'root'
#   group 'root'
#   mode 00644
#   notifies :restart, "service[logstash_server]"
# end
#
# cookbook_file '/etc/logstash/elastic-ossec-template.json' do
#   source 'elastic-ossec-template.json'
#   owner 'root'
#   group 'root'
#   mode 00644
#   notifies :restart, "service[logstash_server]"
# end
