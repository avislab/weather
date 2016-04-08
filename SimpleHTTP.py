#!/usr/bin/env python
# -*- coding: utf-8 -*-

import SimpleHTTPServer
import SocketServer
import os

PORT = 80
DocumentRoot = "/home/pi/weather/http"

os.chdir(DocumentRoot)
Handler = SimpleHTTPServer.SimpleHTTPRequestHandler
httpd = SocketServer.TCPServer(("", PORT), Handler)
print "serving at port", PORT
httpd.serve_forever()

