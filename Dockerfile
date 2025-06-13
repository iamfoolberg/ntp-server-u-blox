# 使用Ubuntu 22.04作为基础镜像
FROM ubuntu:22.04

# 安装必要组件
RUN apt-get update && apt-get install -y \
    gpsd \
    chrony \
    gpsd-clients \
    && rm -rf /var/lib/apt/lists/*

# 配置gpsd
RUN echo "GPSD_OPTIONS=\"-n\"" >> /etc/default/gpsd && \
    echo "DEVICES=\"/dev/ttyACM0\"" >> /etc/default/gpsd && \
    echo "USBAUTO=\"false\"" >> /etc/default/gpsd

# 配置chrony
RUN echo "refclock SHM 0 offset 0.5 delay 0.2 refid NMEA" >> /etc/chrony/chrony.conf && \
    echo "allow all" >> /etc/chrony/chrony.conf

# 通过RUN指令直接创建启动脚本
RUN echo '#!/bin/bash' > /start.sh && \
    echo 'echo "watch gps: cgps -s, watch ntp server: chronyc sources -v"' >> /start.sh && \
    echo 'echo "starting gpsd..."' >> /start.sh && \
    echo 'gpsd -n /dev/ttyACM0 -F /var/run/gpsd.sock' >> /start.sh && \
    echo 'echo "starting chronyd..."' >> /start.sh && \
    echo 'pkill chronyd || chronyd -d -s' >> /start.sh && \
    echo 'echo "service running..."' >> /start.sh && \
    echo 'chronyc sources -v' >> /start.sh && \
    echo 'tail -f /dev/null' >> /start.sh && \
    chmod +x /start.sh

# 暴露NTP端口
EXPOSE 123/udp

ENTRYPOINT ["/start.sh"]
