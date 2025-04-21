// despierta la interface del reloj desde el sistema operativo del reloj
// reemplaza el videojuego con la información del reloj al interior del sistema operativo


import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let "01.tcl" = .init
    }
}
