
%w(1 2).each do |i|
  describe service("consul-template-#{i}") do
    it { should be_installed }
    it { should be_running }
    it { should be_enabled }
  end

  describe file("/etc/consul-template-#{i}/conf.d") do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into "consul-template-#{i}" }
    its('mode') { should cmp '0750' }
  end

  %w(config.json templates.json).each do |f|
    describe file("/etc/consul-template-#{i}/conf.d/#{f}") do
      it { should be_file }
      it { should be_owned_by "consul-template-#{i}" }
      it { should be_grouped_into "consul-template-#{i}" }
      its('mode') { should cmp '0640' }
    end
  end

  describe command("cat /etc/consul-template-#{i}/conf.d/templates.json | jq -r .template[0].source") do
    its('exit_status') { should eq 0 }
    its('stdout') { should eq "/tmp/testfile-#{i}.ctmpl\n" }
  end

  describe file("/tmp/testfile-#{i}.txt") do
    it { should be_file }
    its('content') { should eq "hello-#{i}" }
  end
end
