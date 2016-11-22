

elasticsearch_user 'elasticsearch'

elasticsearch_install 'elasticsearch' do
  type :package.to_s
  version "2.3.4"
  action :install
end

elasticsearch_configure 'elasticsearch' do
  allocated_memory '256m'
  configuration ({
  'cluster.name' => 'rnb_es',
  'node.name' => 'rnb-ossec',
  'network.host' => '_site_'
})
end

elasticsearch_service 'elasticsearch' do
  service_actions [:enable, :start]
end



elasticsearch_plugin 'x-pack' do
  url 'x-pack'
  action :install
  notifies :restart, 'elasticsearch_service[elasticsearch]', :delayed
end
