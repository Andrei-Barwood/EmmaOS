// este programa tiene acceso a la banda del sensor de temperatura del reloj


/* acceso al modo de movimiento del giroscopio */

// reporta si el reloj esta en movimiento
func activityMoveMode() -> HKActivityMoveModeObject {}

// reporta informacion ante cualquier cambio en la configuración del reloj
static let HKUserPreferencesDidChange: NSNotification.Name

/* lectura de signos vitales */

/* test no-intrusivo */

// reporta si el usuario tiene fallos en la memoria, 
// compara los resultados de un test no-intrusivo con un booleano
// el booleano reporta dos valores positivos y uno negativo
// true:
//		- tiene signos vitales y sabe que tiene sintomas de un golpe en el craneo
//		- tiene signos vitales pero no tiene recuerdos claros, o son muy vagos
// false:
//		- perdida de conciencia por algun golpe en el craneo

// reporta si hay o no hay datos de lectura disponibles
class func isHealthDataAvilable() -> Bool {}



// solicita al usuario del reloj permiso para guardar informacion desde un test de lectura no-intrusivo
// si el usuario tiene signos vitales pero rechaza el test, el programa rechaza al usuario y no le devuelve señal 
// de acuso, se cancela la ejecución sin reportar la excepción

// si el reloj recibe señal de autorización del usuario para proceder con un grado de señal mas extenso para el test
// el reloj imprime una lista de permisos solicitados al usuario (para futura referencia de otros administradores de sistema)

func requestAuthorization(
	toShare typesToShare: Set<HKSampleType>?,
	read typesToRead: Set<HKObjectType>?,
	completion: @escaping @Sendable (Bool, (any Error)?) -> Void
) 

{
	set NSHealthShareUsageDescription = false
	set NSHealthUpdateUsageDescription = true
}

// este programa no ofrece servicios para compartir información del reporte, el reporte queda en el dispositivo



/* 	programa para permanecer por tiempo prolongado observando al usuario, si el usuario rechaza el primer test
	el reloj espera un tiempo, elimina la respuesta del usuario y solicita autorización de nuevo.
	si el usuario rechaza un test de resultado positivo con muestras positivas en el reloj por ejemplo
	la persona tiene signos vitales y no presenta contusiones craneales pero rechazó el test, este programa observa
	en modo espera, durante algunos minutos y vuelve a solicitar el proceso pero esta nueva iteración solicita
	guardar los resultados del test positivo en la memoria, 
	este proceso puede tardar lo que resiste la bateria del reloj bajo el agua, si el reloj se apaga queda un registro, 
	que puede ser leído despues de secar y conectar el dispositivo
 */

/* ejecutar el modo observador */
// realiza una copia ligera del resultado y solicita al usuario monitorearla
// la sensibilidad del modo observador se activa si el usuario presenta cambios despues de monitorear la copia ligera
init(sampleType: HKSampleType, predicate: NSPredicate?, updateHandler: (HKObserverQuery, HKObserverQueryCompletionHandler, (any Error)?) -> Void)

// este programa almacena los resultados de la sensibilidad del modo observador si el usuario presentó cambios,
// compara los resultados y ofrece un tipo de señal diferente basada en los resultados del monitoreo y la sensibilidad
// del modo observador
init(queryDescriptors: [HKQueryDecriptor], updateHandler:
	(HKObserverQuery, Set<HKSampleType>?, HKObserverQueryCompletionHandler, (any Error)?) -> Void)

// este programa permite al modo observador leer si el usuario rechaza los test por daños irreversibles
// que no pueden ser observados desde el reloj bajo el agua, en cuyo caso se podría considerar observar
// al usuario fuera del agua
typealias HKObserverQueryCompletionHandler

// por respeto al cadaver, este programa interpretará las respuestas del usuario de 3 maneras en versión simplificada
//		- caso no determinado (usualmente ocurre cuando el cadaver sufrió contusiones craneales y hubo perdida de conciencia)
//		- rechazo rotundo (usualmente ocurre cuando el usuario presenta interferencias o distracciones, se puede abordar con el modo observer)
//		- test autorizado (usualmente ocurre cuando el usuario esta estresado o asustado, tener precaucion porque su pulso cardíaco podría estar acelerado)

case notDetermined = 0
HKAuthorizationStatus.notDetermined

case sharingDenied = 1 							// sharing facebook info rings a bell here, careful
HKAuthorizationStatus.sharingDenied

case sharingAuthorized = 2
HKAuthorizationStatus.sharingAuthorized



// lectura de genero humano
func biologicalSex() -> KHBiologicalSexObject {}

// lectura del tipo de sangre
func bloodType() -> HKBloodTypeObject {}

// el siguiente realiza lectura de actividad neuronal y compara los resultados con la fecha de nacimiento aproximada
func dateOfBirth() -> Date {}

// lectura del estado cutaneo
func fitzpatrickSkinType() -> HKFitzPatrickSkinTypeObject {}

// lectura de la columna vertebral
func wheelchairUse() -> HKWheelchairUseObject {}


/* fin del programa 3 */

// iniciar la orden de lectura
func execute(HKQuery) {}

// detener la orden de lectura
func stop(HKQuery) {}
