if defined?(::ChefSpec)
  require 'chef/config'

  if ::Chef::Config[:smbios_info_disabled].nil?
    ::Chef::Log.warn '[SMBIOS] Do not retrieve SMBIOS info in ChefSpec context'
    ::Chef::Config[:smbios_info_disabled] = true
  end
end
