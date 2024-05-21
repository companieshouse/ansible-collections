#! /usr/bin/bash

if [ -r /etc/motd ]
then
	cat /etc/motd
	printf '%s\n\n' "Connected to $(hostname)"
fi