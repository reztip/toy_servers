require 'socket'               # Get sockets from stdlib

server = TCPServer.open(2000)  # Socket to listen on port 2000
loop {                         # Servers run forever
  client = server.accept       # Wait for a client to connect
  client.puts(Time.now.ctime)  # Send the time to the client
  x = ""
  done = false
  until done
  	new_value = client.gets.chomp
  	puts new_value
  	done = new_value == "xxx"
  	x+=new_value if !done
  end
  puts x
  client.puts "Closing the connection. Bye!"
  client.close                 # Disconnect from the client
}