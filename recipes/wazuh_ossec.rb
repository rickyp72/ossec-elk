# $ sudo apt-get install gcc make git
# If you want to use Auth, also install:
#
# $ sudo apt-get install libssl-dev

apt_package [ 'gcc', 'make', 'git', 'libssl-dev', 'curl' ] do
  action :install
end

git '/root/wazuh' do
  repository 'https://github.com/wazuh/wazuh.git'
  # reference '25c0a98'
  action :sync
end

# TODO:
# BUILD install with params set???
