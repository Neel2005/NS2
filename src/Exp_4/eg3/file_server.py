
import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('', 12346))
s.listen(1)

print("waiting for client")
c, addr = s.accept()
print("connected with", addr)

f = open("received_file.txt", "wb")

while True:
    data = c.recv(1024)
    if not data:
        break
    f.write(data)

f.close()
c.close()
s.close()

print("File received successfully")
