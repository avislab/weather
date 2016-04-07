#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sqlite3

print "Database creating..."

con = sqlite3.connect('weather.db')
cur = con.cursor()
cur.execute('CREATE TABLE weather (id REAL PRIMARY KEY, temperature REAL, pressure REAL, Humidity REAL)')
con.commit()
con.close()

print "done!"
