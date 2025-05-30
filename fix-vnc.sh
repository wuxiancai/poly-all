#!/bin/bash
set -e

# 安装核心依赖
sudo apt update
sudo apt install -y dbus-x11 dbus-user-session xfce4-settings

# 配置用户级 DBus
mkdir -p ~/.dbus
dbus-uuidgen > ~/.dbus/machine-id

# 修改 VNC 启动脚本
cat <<EOF > ~/.vnc/xstartup
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
eval "\$(dbus-launch --sh-syntax --exit-with-session)"
export XKL_XMODMAP_DISABLE=1
exec startxfce4
EOF
chmod +x ~/.vnc/xstartup

# 重启服务
sudo systemctl restart vncserver novnc

echo "修复完成！请重新访问VNC页面"