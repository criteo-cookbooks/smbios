dirname = platform?('windows') ? 'c:\tmp' : '/tmp'

directory dirname do
  action :create
  recursive true
end

file ::File.join(dirname, 'smbios_attributes.json') do
  action :create
  content(lazy { node['smbios'].to_hash.to_json })
end
