
require 'socket'
host = "localhost"
port = 2000
path = "/index.htm"

request = "GET #{path} HTTP/1.0\r\n\r\n"
# q = request_type(request) == "GETS" && path_of_request(request) == "/index.htm"
socket = TCPSocket.open(host, port)
socket.print(request)
# socket.recv_nonblock(1000)
puts socket.read
