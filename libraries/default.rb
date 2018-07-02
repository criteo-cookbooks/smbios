module SMBIOS
  SYSFS_DMI_ID = '/sys/devices/virtual/dmi/id/'.freeze unless constants.include?(:SYSFS_DMI_ID)

  def self.windows_info
    wmi = ::WmiLite::Wmi.new
    system_info = wmi.first_of('WIN32_ComputerSystem')
    bios_info = wmi.first_of('WIN32_Bios')
    ::Mash.new(
      bios:    ::Mash.new(
        date:    bios_info['ReleaseDate'].to_s.unpack('a4a2a2').join('-'),
        vendor:  bios_info['Manufacturer'].to_s.strip,
        version: bios_info['SMBIOSBIOSVersion'].to_s.strip,
      ),
      product: ::Mash.new(
        serial: bios_info['SerialNumber'].to_s.strip,
        name:   system_info['Model'].to_s.strip,
      ),
    )
  end

  def self.linux_info
    info = ::Mash.new
    { product: %w[serial name], bios: %w[date vendor version] }.each do |type, keys|
      info[type] ||= ::Mash.new
      keys.each do |key|
        path = ::File.join(SYSFS_DMI_ID, "#{type}_#{key}")
        info[type][key] = ::File.read(path).strip if ::File.exist?(path)
      end
    end
    # Format bios date to ISO 8601
    info['bios']['date'].gsub!(%r{(\d+)/(\d+)/(\d+).*}, '\3-\1-\2')
    info
  end

  def self.info(node)
    case node['os']
    when 'linux'
      linux_info
    when 'windows'
      windows_info
    else
      ::Chef::Log.warn "[SMBIOS] #{node['os']} is not a supported Operating System."
      ::Mash.new
    end
  end
end
