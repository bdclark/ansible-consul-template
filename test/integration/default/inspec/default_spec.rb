
describe service('consul-template') do
  it { should be_installed }
  it { should be_running }
  it { should be_enabled }
end

describe file('/etc/consul-template/conf.d') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'consul-template' }
  its('mode') { should cmp '0750' }
end

%w(config.json templates.json).each do |f|
  describe file(File.join('/etc/consul-template/conf.d', f)) do
    it { should be_file }
    it { should be_owned_by 'consul-template' }
    it { should be_grouped_into 'consul-template' }
    its('mode') { should cmp '0640' }
  end
end

describe command('cat /etc/consul-template/conf.d/templates.json | jq -r .template[0].source') do
  its('exit_status') { should eq 0 }
  its('stdout') { should eq "/tmp/testfile.ctmpl\n" }
end

describe file('/tmp/testfile.txt') do
  its('content') { should eq 'hello' }
end
