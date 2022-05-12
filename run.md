## What I'm using to run my tests:

```
docker run -d \
  --name=qbittorrent_test33 \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e WEBUI_PORT=8081 \
  -v /mnt/data:/config \
  -v /mnt/data:/downloads \
  --restart unless-stopped \
  test_2
```