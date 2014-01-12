require 'test_helper'

class JavascriptTest < ActionDispatch::IntegrationTest
  def setup
    tcp_server = TCPServer.new('127.0.0.1', 0)
    _, @port = tcp_server.addr
  ensure
    tcp_server.close
  end

  test "javascript" do
    runner = Rails.root.join('test/javascripts/phantom_qunit_runner.js')

    Thread.new do
      Rack::Handler::WEBrick.run(Rails.application, Host: '127.0.0.1', Port: port, AccessLog: [], Logger: WEBrick::Log::new(nil, 0))
    end

    system "phantomjs #{runner} http://127.0.0.1:#{port}/qunit"
  end
end
