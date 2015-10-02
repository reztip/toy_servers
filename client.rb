require 'socket'
hostname = "localhost"
port = 2000
s = TCPSocket.open(hostname, port)
socket = s
# socket.print('a')
# socket.print('b')
puts s.read
s.close