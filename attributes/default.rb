



override['java']['install_flavor'] = 'oracle'
override['java']['jdk_version'] = '8'
override['java']['oracle']['accept_oracle_download_terms'] = true

override['logstash']['instance_default']['version'] = '5.0.1'
override['logstash']['instance_default']['source_url'] = 'https://artifacts.elastic.co/downloads/logstash/logstash-5.0.1.deb'
override['logstash']['instance_default']['checksum'] = 'b302207e2fbf01f2d83fcbf779b94a5680833b81aa3d3a9a5f4aee4b64004154'
override['logstash']['instance_default']['install_type'] = 'package'
override['logstash']['instance_default']['java_home']  = '/usr/lib/jvm/java-8-oracle-amd64'


# override['elasticsearch']['install']['version'] = '5.0.1'
# override['elasticsearch']['checksums']['5.0.1']['debian'] = 'aedbddacbf5c87806ba22d5a953abbef8f54dc0d'
