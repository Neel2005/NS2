
import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(('127.0.0.1', 12346))

f = open("sample.txt", "rb")

while True:
    data = f.read(1024)
    if not data:
        break
    s.sendall(data)

f.close()
s.shutdown(socket.SHUT_WR)
s.close()

print("file sent successfully")
