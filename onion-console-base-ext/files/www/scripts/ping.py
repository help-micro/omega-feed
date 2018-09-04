#!/usr/bin/python

import os

print("Content-Type: text/html\n")

hostname = "google.com"
print("<textarea rows='20' style='width: 100%; height: 100%; resize: none; background: #eee' readonly>")
response = os.popen("ping -c 4 " + hostname).readlines()
for row in response:
	print(row)
print("</textarea>")