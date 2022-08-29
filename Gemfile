source 'https://rubygems.org'

group :unit_test do
  gem 'chef', '= 14.7.17'
  gem 'chefspec', '>= 9.2.1'
end

group :ec2 do
  gem 'kitchen-dokken', '>= 2.17.3'
  gem 'kitchen-inspec', '>= 2.6.1'
  gem 'rake', '>= 13.0.6' # needed to install native inspec deps on Windows
  gem 'test-kitchen', '>= 3.3.2'
end

group :lint do
  gem 'rubocop', '1.35.1'
end
