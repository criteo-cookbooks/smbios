name 'smbios'

run_list %w[smbios smbios-test]

cookbook 'smbios', path: '.'
cookbook 'smbios-test', path: 'test/cookbooks/smbios-test'
