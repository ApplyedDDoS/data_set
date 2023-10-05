#!/bin/bash

# Set the directory where you want to store the pcap and csv files
DIR="./network_traffic"

# Create the directory if it doesn't exist
mkdir -p "$DIR"

while true; do
    # Get current timestamp for unique filenames
    TIMESTAMP=$(date +%Y%m%d%H%M%S)

    # Define file names
    PCAP_FILE="$DIR/traffic_$TIMESTAMP.pcap"
    CSV_FILE="$DIR/traffic_$TIMESTAMP.csv"

    # Capture network traffic for 5 minutes (300 seconds)
    tshark -a duration:60 -w "$PCAP_FILE"

    # Convert pcap to csv using cicflowmeter
    sudo cicflowmeter -f "$PCAP_FILE" -c "$CSV_FILE"

    # Sleep for 5 minutes before capturing again (optional, remove if you want to capture continuously)
    sleep 60
done
