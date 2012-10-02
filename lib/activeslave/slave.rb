module Activeslave
  class Slave
    attr_reader :host, :username, :password, :reconnect, :database, :socket,
                :slave_io_running, :slave_sql_running, :read_only, :scheduler

    def initialize(options)
      @receiver_email = options['receiver_email']
      @host       = options['host']
      @username   = options['username']
      @password   = options['password']
      @database   = options['database']
      @reconnect  = options['reconnect'] || true
      @socket     = options[socket] || '/var/run/mysqld/mysqld.sock'
    end

    def capture_status_values
      slave_client = Mysql2::Client.new({
                      :host      => @host,
                      :username  => @username,
                      :password  => @password,
                      :database  => @database,
                      :reconnect => @reconnect,
                      :socket    => @socket
                    })

      data = slave_client.query("show slave status").first
      @slave_io_running = data['Slave_IO_Running']
      @slave_sql_running = data['Slave_SQL_Running']

      global_variables = slave_client.query("show variables")
      @read_only = global_variables.select{|variable| variable['Variable_name'] == 'read_only'}.first['Value']

      {slave_io_running: slave_io_running, slave_sql_running: slave_sql_running, read_only: read_only}
    end

    def send_notification
      Pony.mail :to           => @receiver_email,
                :subject      => "Your Slave Not Working!",
                :html_body    => "<h2>Slave Status</h2><br>
<table>
    <tr>
      <td>Slave_IO_Running</td>
      <td>#{@slave_io_running}</td>
    </tr>
    <tr>
      <td>Slave_SQL_Running</td>
      <td>#{@slave_sql_running}</td>
    </tr>
    <tr>
      <td>Read_Only</td>
      <td>#{@read_only}</td>
    </tr>
</table>",
                :via          => :sendmail
    end

    def not_working
      @slave_io_running != "Yes" || @slave_sql_running != "Yes" || @read_only != "ON"
    end

    def start_monitor
      @scheduler = Rufus::Scheduler.start_new

      @scheduler.every '5m' do
        capture_status_values

        send_notification if not_working
      end
    end

    def stop_monitor
      @scheduler.stop
    end
  end
end
