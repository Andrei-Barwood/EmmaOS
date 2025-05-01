#!/bin/zsh


if ! command -v adb &> /dev/null; then
  echo "ADB no está instalado. Por favor, instálalo primero."
  exit 1
fi


adb get-state 1>/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "No se detectó ningún teléfono conectado. Asegúrate de que ADB esté activado y autorizado."
  exit 1
fi

echo "Dispositivo detectado. Aplicando configuración de red..."


adb shell "svc data enable"
adb shell "settings put global preferred_network_mode 11"


adb shell "am start -a android.intent.action.MAIN -n com.android.settings/.RadioInfo"

echo "Modo de red 4G LTE Only aplicado exitosamente."
