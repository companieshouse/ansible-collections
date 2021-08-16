#!/bin/bash

export LOG="/var/log/clamav/scan.log"
export TARGET="/"
export SUMMARY_FILE=`mktemp`
export FIFO_DIR=`mktemp -d`
export FIFO="$FIFO_DIR/log"

export SCAN_STATUS
export INFECTED_SUMMARY

mkfifo "$FIFO"
tail -f "$FIFO" | tee -a "$LOG" "$SUMMARY_FILE" &

echo "------------ SCAN START ------------" > "$FIFO"
echo "Running scan on `date`" > "$FIFO"
echo "Scanning $TARGET" > "$FIFO"
sudo clamdscan --infected --multiscan --fdpass --stdout "$TARGET" | grep -vE 'WARNING|ERROR|^$' > "$FIFO"
echo > "$FIFO"

SCAN_STATUS="${PIPESTATUS[0]}"
INFECTED_SUMMARY=`cat "$SUMMARY_FILE" | grep "Infected files"`

rm "$SUMMARY_FILE"
rm "$FIFO"
rmdir "$FIFO_DIR"

if [[ "$SCAN_STATUS" -ne "0" ]] ; then

  # Send the alert to systemd logger if exist
  if [[ -n $(command -v systemd-cat) ]] ; then
    echo "Virus signature found - $INFECTED_SUMMARY" | /usr/bin/systemd-cat -t clamav -p emerg
  elif [[ -n $(command -v logger) ]] ; then
    echo "Virus signature found - $INFECTED_SUMMARY" | /usr/bin/logger -t clamav 
  fi

elif [[ "$SCAN_STATUS" -eq "0" ]] ; then

  # Send successful scan message
  if [[ -n $(command -v systemd-cat) ]] ; then
    echo "Scan complete, system clean" | /usr/bin/systemd-cat -t clamav -p emerg
  elif [[ -n $(command -v logger) ]] ; then
    echo "Scan complete, system clean" | /usr/bin/logger -t clamav 
  fi

fi


