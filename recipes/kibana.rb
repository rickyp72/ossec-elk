# TODO:
# $ wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
# $ echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" | sudo tee -a /etc/apt/sources.list
# $ sudo apt-get update && sudo apt-get install kibana

# /opt/kibana/bin/kibana and add the following line
#
# NODE_OPTIONS="${NODE_OPTIONS:=--max-old-space-size=250}"
# TODO:
# CONFIGURE
# Kibana is bound by default to 0.0.0.0 address (listening on all addresses), it uses by default 5601 port and try to connect to Elasticsearch using the URL http://localhost:9200. If you need to change any of this settings, open the /opt/kibana/config/kibana.yml configuration file and set up the following variables:
#
# # Kibana is served by a back end server. This controls which port to use.
# server.port: 80
#
# # The host to bind the server to.
# server.host: "0.0.0.0"
#
# # The Elasticsearch instance to use for all your queries.
# elasticsearch.url: "http://127.0.0.1:9200"
# TODO:
# # Kibana is served by a back end server. This controls which port to use.
# server.port: 80
#
# # The host to bind the server to.
# server.host: "0.0.0.0"
#
# # The Elasticsearch instance to use for all your queries.
# elasticsearch.url: "http://127.0.0.1:9200"

# CONNECT TO KIBANA
# To create OSSEC alerts index, access your Kibana interface at http://your_server_ip:5601, Kibana will ask you to “Configure an index pattern”, set it up following these steps:
#
# - Check "Index contains time-based events".
# - Insert Index name or pattern: ossec-*
# - On "Time-field name" list select @timestamp option.
# - Click on "Create" button.
# - You should see the fields list with about ~72 fields.
# - Go to "Discover" tap on top bar buttons.
