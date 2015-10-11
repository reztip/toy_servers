require 'json'
require 'socket'
host = "localhost"
port = 2000
puts "What file are you looking for (relative to the current working directory)?"
path = gets.chomp
path = "/index.htm" unless path =~ /.+\..+/ #valid file extension (not fully checked)
puts "Do you want to perform a GET or POST request?"
client_input = gets.chomp
request_type = "GET" if client_input =~ /[Gg].*/
request_type = "POST" if client_input =~ /[Pp].*/

if request_type == "POST"
  puts "Name?"
  name = gets.chomp
  puts "e-mail?"
  email = gets.chomp
  value_to_post = {identifiers: {name: name, email: email} }
  client_representation =JSON.generate value_to_post
  content_length = client_representation.length
end

# request = "#{request_type} #{path} HTTP/1.0\r\n\r\n#{client_representation ? " " + client_representation : ""}"
case request_type
	when "GET"
      request = "#{request_type} #{path} HTTP/1.0\r\n\r\n"
  	when "POST"
  	  request = "#{request_type} #{path} HTTP/1.0\r\n\r\n" + "Content-Length: #{content_length}\n" + "#{client_representation}"
	else #nothing
end

if request_type
	socket = TCPSocket.open(host, port)
	socket.print(request)
	# socket.recv_nonblock(1000)
	puts socket.read
end