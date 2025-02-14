Revisar problema para instalar pip e instala librerias:
- passlib


instalar para tener docker_compose
ansible-galaxy collection install community.docker
Al final tiro de shell y fuera

## Mocked cameras
La mejor manera es poner un video en el path
Acuerdate de montar el fichero del video en el docker compose para poder apuntar el path de la config  a donde apuntes
```yaml
cameras:
  mocked_camera_1:
    ffmpeg:
      inputs:
        - path: /config/videoplayback.mp4
          input_args: -re -stream_loop -1 -fflags +genpts
```

## NOTES

The FPS are caped to 10fps on livemode and birdseye, and to 5 on debug
https://github.com/blakeblackshear/frigate/discussions/3066