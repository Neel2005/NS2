
import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

port = 12345
s.bind(('', port))

print("socket successfully created")
print("socket with port", port)

s.listen(5)
print("socket is listening")

c, addr = s.accept()
print("connection from", addr)

c.send("thank you for connecting".encode())

c.close()
s.close()
