# ntp-server-u-blox
This is a ntp server docker image, by USB GPS devices, such as u-blox 
# build it
```docker build -t berg/ntpserver:1.0 .```
# run it
```
docker run -itd --name myntpserver \
  -p 8123:123/udp \
  --device=/dev/ttyACM0 \
  --cap-add=SYS_TIME \
  -v /docker/data/simplentpserver/mychrony.conf:/etc/chrony/chrony.conf  \
  -v /docker/data/simplentpserver/mystart.sh:/start.sh \
  berg/ntpserver:1.0
```
# watch in container
```docker exec -it myntpserver bash```
