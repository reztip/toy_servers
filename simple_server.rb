require 'socket'                # Get sockets from stdlib

def request_type(request) #request should be client.gets
  fields = request.split(' ')
  # return nil if fields.length != 3
  # puts fields.first + " is field.first"
  return "GET" if request =~ /GET .*/
  return "POST" if request =~ /POST .*/
  return nil
end

def path_of_request(request)
  fields = request.split(' ')
  return nil if fields.length != 3
  return fields[1]
end

def valid_request?(request)
  return true if (request =~ /GET .* HTTP.*/) || (request =~ /POST .* HTTP.*/)
end


server = TCPServer.open(2000)   # Socket to listen on port 2000
loop {                          # Servers run forever
    client = server.accept
    # client.puts(Time.now.ctime) # Send the time to the client
    request= client.gets.chomp
    client.puts(request)
    # client.puts(request_type(request) == "GETS")
    get_index = true if valid_request?(request) && request_type(request) == "GET" && path_of_request(request) == "/index.htm"
    if get_index
    	begin
    	  file = File.open(File.expand_path("./index.html"))
    	  response_line = "HTTP/1.0 200 OK"
    	  response_body = file.read
    	  file.close
    	ensure
    	  response_line ||= "HTTP/1.0 404 Not Found"
    	end
    	
    else
    	response_line = "HTTP/1.0 404 Not Found"
    end

    client.puts(response_line + "\n" + Time.now.ctime.to_s + "\r\n\r\n" + (response_body ? response_body.to_s : "") )

	client.puts "Closing the connection. Bye!"
    client.close                # Disconnect from the client

}


