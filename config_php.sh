#!/usr/bin/env bash

# Build=true when installing on a live unknown server

config_php=(
#  'version    shortname  port  build'
   '5.4.45     5.4        9004  true'
   '5.5.38     5.5        9005  true'
   '5.6.35     5.6        9006  true'
   '7.0.29     7.0        9007  true'
   '7.1.16     7.1        9008  true'
   '7.2.4      7.2        9009  true'
)

web_user='www-data';
web_group='www-data';
