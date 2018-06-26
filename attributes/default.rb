default['smbios'] # auto-vivify the root SMBIOS attribute

unless ::Chef::Config[:smbios_info_disabled]
  # Provide SMBIOS info
  automatic_attrs['smbios'] = ::SMBIOS.info(node)
end
