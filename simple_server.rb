require 'socket'                # Get sockets from stdlib

server = TCPServer.open(2000)   # Socket to listen on port 2000
loop {                          # Servers run forever
  Thread.start(server.accept) do |client|
    client.puts(Time.now.ctime) # Send the time to the client
    request= client.gets
    get_index? = true if request_type(request) == "GETS" && path_of_request(request) == "/index.html"
    if get_index?
    	file = File.open("./index.html")
    	header = 1
    	client.puts file.read
    end
	# client.puts "Closing the connection. Bye!"
    client.close                # Disconnect from the client
  end
}


def request_type(request) #request should be client.gets
  fields = request.split(' ')
  return nil if fields.length != 3
  return "GETS" if fields.first.match(/[Gg][Ee][Tt][Ss]/)
  return "POST" if fields.first.match(/[Pp][Oo][Ss][Tt]/)
  return nil
end

def path_of_request(request)
  fields = request.split(' ')
  return nil if fields.length != 3
  return fields[1]
end