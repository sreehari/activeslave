require 'spec_helper'


describe Activeslave::Slave do
  before(:each) do
    @slave = Activeslave::Slave.new DatabaseCredentials['slave']
  end

  it 'should capture the slave status' do
    @slave.capture_status_values.should == {slave_io_running: 'No', slave_sql_running: 'Yes', read_only: 'OFF'}
  end

  describe 'start_monitor' do
    it 'should notification when slave stop working' do
      Pony.should_receive(:mail)
      @slave.send_notification
    end
  end
end