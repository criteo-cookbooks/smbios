attributes_file = os.linux? ? '/tmp/smbios_attributes.json' : 'C:\tmp\smbios_attributes.json'

describe file(attributes_file) do
  it { should exist }
end

describe json(attributes_file) do
  its(%w[bios date]) { should_not be_empty }
  its(%w[bios vendor]) { should_not be_empty }
  its(%w[bios version]) { should_not be_empty }
  its(%w[product serial]) { should_not be_empty }
  its(%w[product name]) { should_not be_empty }
end
