
import socket
import threading

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

host = '0.0.0.0'
port = 40674

server.bind((host, port))
server.listen(1)

print("server listening on port", port)

client, addr = server.accept()
print("connected with", addr)

def receive_messages():
    while True:
        try:
            data = client.recv(1024)
            if not data:
                break
            print("\nclient:", data.decode())
        except OSError:
            break

def send_messages():
    while True:
        msg = input("you: ")
        if msg.lower() == 'exit':
            client.close()
            break
        try:
            client.sendall(msg.encode())
        except OSError:
            break

threading.Thread(target=receive_messages, daemon=True).start()
send_messages()

server.close()
