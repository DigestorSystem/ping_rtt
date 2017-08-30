#!/bin/bash

user=$(whoami)
replay_server_ip="134.147.203.223"
interval=10
iterations=1000

printf "AUTHENTICATE \"\"\r\n" | nc 127.0.0.1 9051

for i in `seq 1 1000`;
do
    echo "Iteration" $i
    date_time=$(date '+%Y_%m_%d_%H_%M_%S')
    target=/home/"$user"/tor_latency/$date_time/
    mkdir -p "$target"
    ./nc -j "$iterations" -i "$interval" -X5 -x 127.0.0.1:9050 "$replay_server_ip" 8888 > "$target/results.txt" 2>&1 & 
    pid_nc=$!
    echo "pid_nc" $pid_nc
    export pid_nc=$pid_nc
    job_id=$(jobs -l | perl -n -e '/\[(\d+)\][+-]\s(\d+)/;if ($2 == $ENV{pid_nc}) {printf $1}')
    echo "jobid" $job_id
    printf "AUTHENTICATE \"\"\r\ngetinfo stream-status\r\ngetinfo circuit-status\r\n" | nc 127.0.0.1 9051 > "$target/ciruit_informations.txt"
    wait %$job_id
    printf "AUTHENTICATE \"password\"\r\nSIGNAL NEWNYM\r\n" | nc 127.0.0.1 9051  >> "$target/ciruit_informations.txt"
    sleep 1
done    


