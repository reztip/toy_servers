require 'socket'                # Get sockets from stdlib
require 'json'

def request_type(request) #request should be client.gets
  fields = request.split(' ')
  # return nil if fields.length != 3
  # puts fields.first + " is field.first"
  return "GET" if request =~ /GET .*/
  return "POST" if request =~ /POST .*/
  return nil
end

def path_of_request(request)
  fields = request.split(/\s+/)
  # return nil if fields.length != 3
  return fields[1]
end

def valid_request?(request)
  return true if (request =~ /GET .* HTTP.*/) || (request =~ /POST .* HTTP.*/)
end

def client_representation #only for post requests
	fields = request.split(/\s+/)
	fields[3..-1].join
  
end

def content_type(request_path)
  ext = File.extname(request_path)
  case ext
    when ".html", ".htm"
    	return "text/html"
    when ".txt", ".rb", ".py", ".java"
    	return "text/plain"
    when ".css"
    	return "text/css"
    when ".jpeg", ".jpg"
    	return "image/jpeg"
    when ".gif"
    	return "image/gif"
    when ".xml"
    	return "text/html"
    else
    	return "text/plain"
    end
end
	
server = TCPServer.open(2000)   # Socket to listen on port 2000
loop {                          # Servers run forever
    client = server.accept
    request= client.gets.chomp
    path = path_of_request(request)
    get_index = true if valid_request?(request) && request_type(request) == "GET" && path == "/index.htm"
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

    client.puts(response_line)
    client.puts(Time.now.ctime.to_s)
    client.puts("From: ")
    client.puts("User-Agent: HTTPTool/1.0")
    client.puts("Content-Type: #{ content_type(path) }"
    client.puts("Content-Length: #{ response_body ? response_body.to_s.length : 0 }")

    client.puts(response_body ? response_body.to_s : "")
    client.close                # Disconnect from the client

}


