

elasticsearch_user 'elasticsearch'

elasticsearch_install 'elasticsearch' do
  type :package.to_s
end
