name 'ossec-elk'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'all_rights'
description 'Installs/Configures ossec-elk'
long_description 'Installs/Configures ossec-elk'
version '0.3.0'
# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/ossec-elk/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/ossec-elk' if respond_to?(:source_url)
depends 'elasticsearch', '>= 3.0.1'
depends 'apt'
depends 'yum'
depends 'curl'
depends 'java'
depends 'kibana'
