#!/usr/bin/env python

"""
A simple echo server
"""

import socket, sys

port = sys.argv[1]

print "Running TCP echo on port: " + port 

host = ''
backlog = 5
size = 1024
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((host,int(port)))
s.listen(backlog)
while 1:
    client, address = s.accept()
    data = client.recv(size)
    if data:
        client.send(data)
    client.close()

