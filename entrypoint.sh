#!/bin/sh
if [ -z $MODE ]; then
  MODE=server
fi
if [ $BIND_PORT ]; then
  sed -i "s|bind_port = 7000|bind_port = $BIND_PORT|g" /frp/frps.ini
fi
if [ $SERVER_ADDR ]; then
  sed -i "s|server_addr = 127.0.0.1|server_addr = $SERVER_ADDR|g" /frp/frpc.ini
fi
if [ $SERVER_PORT ]; then
  sed -i "s|server_port = 7000|server_port = $SERVER_PORT|g" /frp/frpc.ini
fi
if [ $PROTO ]; then
  sed -i "s|type = tcp|type = $PROTO|g" /frp/frpc.ini
fi
if [ $LOCAL_IP ]; then
  sed -i "s|local_ip = 127.0.0.1|local_ip = $LOCAL_IP|g" /frp/frpc.ini
fi
if [ $LOCAL_PORT ]; then
  sed -i "s|local_port = 22|local_port = $LOCAL_PORT|g" /frp/frpc.ini
fi
if [ $REMOTE_PORT ]; then
  sed -i "s|remote_port = 6000|remote_port = $REMOTE_PORT|g" /frp/frpc.ini
fi
if [ $MODE = server ]; then
  /frp/frps -c /frp/frps.ini
else
  /frp/frpc -c /frp/frpc.ini
fi