nohup ./"02 - El Inicio.zsh" &
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable "04 - Salir.service"
sudo systemctl start "04 - Salir.service"
systemctl status "04 - Salir.service"

