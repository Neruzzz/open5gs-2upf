# Usamos una imagen base de Debian, ya que VLC se puede instalar fácilmente en Debian y sus derivados.
FROM debian:bullseye-slim

# Actualizamos los paquetes e instalamos VLC sin recomendar paquetes para mantener el tamaño al mínimo.
RUN apt-get update && apt-get install -y --no-install-recommends vlc-bin vlc-plugin-base && \
    rm -rf /var/lib/apt/lists/*

# Crea un usuario no root llamado 'vlcuser' y establece el directorio de trabajo
RUN useradd -m vlcuser
WORKDIR /home/vlcuser

# Cambia al usuario no root
USER vlcuser

# Expone el puerto 8080, que VLC usará para transmitir el video.
EXPOSE 8080

# Usa cvlc (la versión sin interfaz de VLC) para iniciar la transmisión cuando el contenedor se ejecute.
# Asegúrate de que el volumen montado sea accesible por el usuario no root, ajustando los permisos del archivo de video según sea necesario.
CMD ["cvlc", "-vvv", "/mnt/streaming/12AngryMen.mp4", "--sout", "#transcode{vcodec=h264,acodec=mpga,vb=800,ab=128}:standard{access=http,mux=ts,dst=:8080}", "--no-sout-all", "--sout-keep"]
