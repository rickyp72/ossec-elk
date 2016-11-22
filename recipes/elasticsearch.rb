

elasticsearch_user 'elasticsearch'

elasticsearch_install 'elasticsearch' do
  type :package.to_s
  version "2.3.4"
  download_url "https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.4/elasticsearch-2.3.4.deb"
  download_checksum "abf6ce899cb7f2d9fc6eae0ecba148a191093e62afd1e242ba0bb1a7c2686074" # sha256 checksum
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
