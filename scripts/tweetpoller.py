#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
import tweepy, pytumblr, time, sys
from datetime import datetime

MIN_TEMP = -50
ERROR_TEMP = -999.99

mainRoom = open("/sys/bus/w1/devices/28-000005501105/w1_slave")
thetext = mainRoom.read()
mainRoom.close()
tempdata = thetext.split("\n")[1].split(" ")[9]
temperature = float(tempdata[2:])
temperature = str(temperature / 1000)

# Twitter credentials
CONSUMER_KEY = ''
CONSUMER_SECRET = ''
ACCESS_KEY = ''
ACCESS_SECRET = ''

auth = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
auth.set_access_token(ACCESS_KEY, ACCESS_SECRET)
api = tweepy.API(auth)

photo = 'hour.png'
status = "WeatherStation\nTemperature in Main Room: " + temperature + "°C \nMore at http://rrdture.bartbania.com\n#weather #RaspberryPi #Linux"

api.update_with_media(photo, status=status)
