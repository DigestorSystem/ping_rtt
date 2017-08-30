debian package:
sudo apt install libbsd-dev 
Client:
./nc -j 6000 -i 10 -X5 -x 127.0.0.1:9050 server_ip 8888 > file_pipe
Server:
./nc 8888 -R -l