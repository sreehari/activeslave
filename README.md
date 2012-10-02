# Activeslave

mysql-slave sends an email notification when slave stop working

## Installation

Add this line to your application's Gemfile:

    gem 'activeslave'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activeslave

## Usage

Create Slave object
  slave = Activeslave::Slave.new( "host"            => "xxx.xxx.xx.xx",
                                  "username"        => "xxxxxx",
                                  "password"        => "xxxxxx",
                                  "database"        => "slavedb",
                                  "socket"          => "/var/run/mysqld/mysqld.sock",
                                  "receiver_email"  => "sreehari@activesphere.com")
Start monitor
  slave.start_monitor

Stop monitor
  slave.stop_monitor

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
