#!/bin/bash

# 检查是否提供了用户名和密码环境变量
if [[ -z "$WEBDAV_USER" ]] || [[ -z "$WEBDAV_PASSWORD" ]]; then
    echo "Error: WEBDAV_USER and WEBDAV_PASSWORD environment variables must be set."
    exit 1
fi

# 使用 htpasswd 生成用户名和密码文件
htpasswd -cb /config/.htpasswd $WEBDAV_USER $WEBDAV_PASSWORD

# 启动 Nginx
exec nginx -g 'daemon off;'
