require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'activeslave'

DatabaseCredentials = YAML.load_file('spec/configuration.yml')

RSpec.configure do |config|

end