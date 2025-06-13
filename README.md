# ntp-server-u-blox
This is a ntp server docker image, by USB GPS devices, such as u-blox 
# build it
```docker build -t berg/ntpserver:1.0 .```
# run it
find your gps/beidou.. device(who uses nmea protocol), e.g. /dev/ttyACM0 for my u-blox
![图片](https://github.com/user-attachments/assets/0fab31e1-5c9e-4363-8282-7ff2cf10007b)

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
```
docker exec -it myntpserver bash
watch gps: cgps -s
watch ntp server: chronyc sources -v
```
