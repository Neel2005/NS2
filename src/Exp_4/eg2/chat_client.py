
import socket
import threading

host = '127.0.0.1'
port = 40674

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
    client.connect((host, port))
except OSError as e:
    print("connection failed:", e)
    client.close()
    raise SystemExit

def receive_messages():
    while True:
        try:
            data = client.recv(1024)
            if not data:
                break
            print("\nserver:", data.decode())
        except OSError:
            break

threading.Thread(target=receive_messages, daemon=True).start()

while True:
    msg = input("You: ")
    if msg.lower() == 'exit':
        break
    try:
        client.sendall(msg.encode())
    except OSError:
        break

client.close()
