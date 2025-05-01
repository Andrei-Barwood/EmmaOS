#!/bin/zsh


SCRIPT_PATH="$HOME/'01 - El Destino.zsh'"


INTERVALO=1


if [ ! -f "$SCRIPT_PATH" ]; then
  echo "Error: No se encontró el script '$SCRIPT_PATH'"
  exit 1
fi

echo "Iniciando monitor de red 4G. Ejecutando cada $((INTERVALO/60)) minutos..."

while true; do

  if adb get-state 1>/dev/null 2>&1; then
    echo "[`date '+%H:%M:%S'`] Dispositivo conectado. Ejecutando forzar_4g.sh..."
    zsh "$SCRIPT_PATH"
  else
    echo "[`date '+%H:%M:%S'`] Sin dispositivo conectado. Reintentando en $((INTERVALO/60)) minutos."
  fi

  sleep $INTERVALO
done
