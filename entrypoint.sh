#!/bin/sh
if [ -z $MODE ]; then
  MODE=server
fi

if [ $MODE = server ]; then
  if [ $BIND_PORT ]; then
    sed -i "s|bind_port = 7000|bind_port = $BIND_PORT|g" /frp/frps.ini
  fi
  if [ $DASHBOARD_PORT ]; then
    sed -e "s|dashboard_port = 7500|dashboard_port = $DASHBOARD_PORT|g" /frp/frps.ini
  fi
  if [ $DASHBOARD_USER ]; then
    sed -e "s|dashboard_user = 7500|dashboard_user = $DASHBOARD_USER|g" /frp/frps.ini
  fi
  if [ $DASHBOARD_PWD ]; then
    sed -e "s|dashboard_user = 7500|dashboard_user = $DASHBOARD_PWD|g" /frp/frps.ini
  fi
  cat /frp/frps.ini
  /frp/frps -c /frp/frps.ini
else
  if [ $SERVER_ADDR ]; then
    sed -i "s|server_addr = 127.0.0.1|server_addr = $SERVER_ADDR|g" /frp/frpc.ini
  fi
  if [ $PROXY_NAME ]; then
    sed -i "s|ssh|$PROXY_NAME|g" /frp/frpc.ini
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
  cat /frp/frpc.ini
  /frp/frpc -c /frp/frpc.ini
fi
