#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sqlite3
import urllib2
import time
import datetime
import re
import os
from BME280 import *
from Adafruit_CharLCD import Adafruit_CharLCD

#========================================
# Settings
#========================================
home_dir = "/home/pi/weather/"
www_dir = "/var/www/weather/"
delete_data_older_than_days = 30
temperature_unit = 'C' # 'C' | 'F'
pressure_unit = 'mm Hg' # 'Pa' | 'mm Hg'
humidity_unit = '%'
#========================================
database_name = 'weather.db'
temperature_field = 'temperature'
pressure_field = 'pressure'
humidity_field = 'humidity'

units = {temperature_field: temperature_unit, pressure_field: pressure_unit, humidity_field: humidity_unit}

def convert(value, unit):
	if unit == 'F':
		# Convert from Celsius to Fahrenheit
		return round(1.8 * value + 32.0, 2)
	if unit == 'mm Hg':
		 #Convert from Pa to mm Hg
		return round(value * 0.00750061683, 2)
	return value

def get_chart_data(field, days):
	global units
	result = ""
	start_time =  time.time() - 86400*days
	SQL = "SELECT id, {0} FROM weather WHERE (id > {1}) ORDER BY id DESC".format(field, start_time)
	cur.execute(SQL)
	for row in cur:
		value = convert(row[1], units[field])
		result += "[new Date({0}), {1}], ".format(int(row[0]*1000), value)
	result = re.sub(r', $', '', result)
	return result

#Read data from Sensor
ps = BME280()
ps_data = ps.get_data()
print "Temperature:", convert(ps_data['t'], units[temperature_field]), "°"+units[temperature_field], "Pressure:", convert(ps_data['p'], units[pressure_field]), units[pressure_field], "Humidity:", ps_data['h'], units[humidity_field]

#LCD
lcd = Adafruit_CharLCD()
lcd.clear()
lcd.home()
lcd.message('T=%s  P=%s\n' % (convert(ps_data['t'], units[temperature_field]), convert(ps_data['p'], units[pressure_field])))
lcd.message('H=%s%%' % (ps_data['h']))

# ESPEAK
#speak_str = "Тем пе ратура "
#if ps_data['t'] < 0:
#	speak_str += "минус"
#speak_str += str(int(round(abs(ps_data['t']))))
#os.system('espeak "' + speak_str + '" -vru -s50 -a100 2> /dev/null')

#Connect to database
con = sqlite3.connect(home_dir + database_name)
cur = con.cursor()

#Insert new reccord
SQL="INSERT INTO weather VALUES({0}, '{1}', {2}, {3})".format(time.time(), ps_data['t'], ps_data['p'], ps_data['h'])
cur.execute(SQL)
con.commit()

#Delete data older than 30 days
start_time =  time.time() - 86400 * delete_data_older_than_days
SQL = "DELETE FROM weather WHERE (id < {0})".format(start_time)
cur.execute(SQL)
con.commit()

#Read template & make index.htm
f = open(home_dir+'templates/index.tpl', 'r')
txt = f.read()
f.close()

#Prepare html
date_time = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M')

#Units
txt = re.sub('{temperature_unit}', units[temperature_field], txt)
txt = re.sub('{pressure_unit}', units[pressure_field], txt)
txt = re.sub('{humidity_unit}', units[humidity_field], txt)

#Current data
txt = re.sub('{time}', date_time, txt)
txt = re.sub('{temperature}', str(convert(ps_data['t'], units[temperature_field])), txt)
txt = re.sub('{pressure}', str(convert(ps_data['p'], units[pressure_field])), txt)
txt = re.sub('{humidity}', str(ps_data['h']), txt)

#Day ago
txt = re.sub('{temperature24h}', get_chart_data(temperature_field, 1), txt)
txt = re.sub('{pressure24h}', get_chart_data(pressure_field, 1), txt)
txt = re.sub('{humidity24h}', get_chart_data(humidity_field, 1), txt)

#Last week
txt = re.sub('{temperature7d}', get_chart_data(temperature_field, 7), txt)
txt = re.sub('{pressure7d}', get_chart_data(pressure_field, 7), txt)
txt = re.sub('{humidity7d}', get_chart_data(humidity_field, 7), txt)

#Writing file index.htm
f = open(www_dir+'index.htm','w')
f.write(txt)
f.close()

#Database connection close
con.close()

#Send data to my site
s="{0}:{1}:0:{2}:".format(int(ps_data['p']), int(ps_data['t']), int(ps_data['h']))
response = urllib2.urlopen("http://avispro.com.ua/getdata.php?data="+s)
