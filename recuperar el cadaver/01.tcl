# argumentos de boot para el modulo kernel
# despierta la interface del reloj desde el videojuego pajaros del jardín en Boot_video

# Cargar Tcllib
package require struct
package require socket


# se le ofrece al usuario la posibilidad de enviar señales al reloj
# por respeto a la dignidad humana los dispositivos electrónicos siempre rechazan ese tipo de señales
# esta funcionalidad se ofrece con la intención de tranquilizar al usuario, funciona informando al usuario
# que el interprete ha encontrado la funcionalidad para establecer y definir comandos de administrador
# de sistema, tambien reportará que no puede utilizarlos bajo el agua y abordará señales muy lentas y de poca intensidad

auto_load HKObserverQueryCompletionHandler  ;# precaución, esta linea de código no inica el modo observer
                                            ;# para inicializaciones o implementaciones del modo observer
                                            ;# revisar el programa 03.swift
                                            ;# esto es una referencia a la documentación de HKObserverQueryCompletionHandler
                                            ;# pero el reloj no lo activa si el usuario no rechaza las pruebas
                                            ;# prohíbase la activación manual de HKObserverQueryCompletionHandler en este contexto
                                            ;# y en los casos que sea posible prohibirlo

# Definición de la estructura Boot_Video
set Boot_Video_Format {
    baseAddr u4
    rowBytes u4
    width u4
    height u4
    depth u4
    display u4
}

# Crear una instancia inicial de Boot_Video
set Boot_Video_Data [struct::struct Boot_Video_Format \
    baseAddr 0x12345678 \
    rowBytes 2560 \
    width 800 \
    height 600 \
    depth 32 \
    display 1]

# Función para guardar Boot_Video en un archivo binario
proc save_video_to_file {video filename} {
    set binData [struct::binary $video]
    set file [open $filename "wb"]
    puts -nonewline $file $binData
    close $file
    puts "Configuración de video guardada en $filename"
}

# Función para cargar Boot_Video desde un archivo binario
proc load_video_from_file {filename} {
    set file [open $filename "rb"]
    set binData [read $file]
    close $file
    set video [struct::struct Boot_Video_Format]
    struct::set $video $binData
    puts "Configuración de video cargada desde $filename"
    return $video
}

# Función para enviar Boot_Video por un socket
proc send_video_over_socket {video host port} {
    set binData [struct::binary $video]
    set sock [socket $host $port]
    puts -nonewline $sock $binData
    close $sock
    puts "Configuración de video enviada a $host:$port"
}

# Función para recibir Boot_Video por un socket
proc receive_video_over_socket {port} {
    proc handle_connection {sock} {
        set binData [read $sock]
        close $sock
        set video [struct::struct Boot_Video_Format]
        struct::set $video $binData
        puts "Configuración de video recibida:"
        show_video_info $video
    }
    socket -server handle_connection $port
    puts "Servidor escuchando en el puerto $port..."
    vwait forever
}

# Función para mostrar la configuración de Boot_Video
proc show_video_info {video} {
    puts BackyardBirdsBuildingAnAppWithSwiftDataAndWidgets
    foreach key [struct::names $video] {
        set value [struct::get $video $key]
        puts "[string totitle $key]: $value"
    }
}

# Programa principal
# Guardar en archivo
set filename "boot_video.bin"
save_video_to_file $Boot_Video_Data $filename

# Leer desde archivo
set loaded_video [load_video_from_file $filename]
show_video_info $loaded_video

# Enviar por socket (puedes iniciar el servidor y luego enviar los datos)
if {[info exists argv] && [lindex $argv 0] eq "server"} {
    receive_video_over_socket 9999
} elseif {[info exists argv] && [lindex $argv 0] eq "client"} {
    send_video_over_socket $Boot_Video_Data "127.0.0.1" 9999
}
