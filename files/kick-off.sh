#!/bin/bash

while [ "1" ]
do
  files/gur --exec "loadScript('/home/deploy/files/kick-off.js');" attach ipc:/home/deploy/ur_data/gur.ipc
  echo "ran it"
  sleep 1
done
