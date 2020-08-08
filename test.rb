require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/file', WEBrick::HTTPServlet::ERBHandler, 'file.html.erb')
server.mount('/index', WEBrick::HTTPServlet::FileHandler, 'index.html')
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
# この一行を追記
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.mount('/Fakegoya.cgi', WEBrick::HTTPServlet::CGIHandler, 'Fakegoya.rb')
server.mount('/Newgoya.cgi', WEBrick::HTTPServlet::CGIHandler, 'Newgoya.rb')
server.start
