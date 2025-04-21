import SwiftUI
import RealityKit

@main
struct VisionOSInteractiveApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.openRealityView, InteractiveRealityView())
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("la documentación de la libreria estándar de C")
                .font(.largeTitle)
                .bold()
                .padding()

            Text("Toca, gira o pellizca alguna figura para interactuar.")
                .font(.body)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
    }
}

struct InteractiveRealityView: RealityView {
    @State private var scale: Float = 1.0
    @State private var rotation: simd_quatf = simd_quatf(angle: 0, axis: [0, 1, 0])

    func makeRealityView() -> ARView {
        let arView = ARView(frame: .zero)

        // Crear un cubo con material
        let cubeMesh = MeshResource.generateBox(size: 0.2)
        let cubeMaterial = SimpleMaterial(color: .blue, isMetallic: true)
        let cubeEntity = ModelEntity(mesh: cubeMesh, materials: [cubeMaterial])

        // Agregar el cubo a un anclaje
        let anchorEntity = AnchorEntity(world: [0, 0, -1]) // Anclaje a 1 metro frente al usuario
        anchorEntity.addChild(cubeEntity)
        arView.scene.anchors.append(anchorEntity)

        // Configurar gestos
        setupGestures(for: cubeEntity, in: arView)

        return arView
    }

    func setupGestures(for entity: ModelEntity, in arView: ARView) {
        // Gesto de rotación
        let rotationGesture = EntityGestureRecognizer(entity: entity, type: .rotation) { rotation in
            entity.transform.rotation = rotation
        }

        // Gesto de escala
        let scaleGesture = EntityGestureRecognizer(entity: entity, type: .scale) { scale in
            entity.scale = SIMD3<Float>(repeating: scale)
        }

        // Agregar los gestos al ARView
        arView.addGestureRecognizer(rotationGesture)
        arView.addGestureRecognizer(scaleGesture)
    }
}

enum EntityGestureRecognizerType {
    case rotation, scale
}

class EntityGestureRecognizer: UIGestureRecognizer {
    private let entity: ModelEntity
    private let type: EntityGestureRecognizerType
    private let action: (simd_quatf) -> Void

    init(entity: ModelEntity, type: EntityGestureRecognizerType, action: @escaping (simd_quatf) -> Void) {
        self.entity = entity
        self.type = type
        self.action = action
        super.init(target: nil, action: nil)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let touch = touches.first else { return }
        let delta = touch.translation(in: view)

        switch type {
        case .rotation:
            // Calcular rotación a partir del movimiento del dedo
            let angle = Float(delta.x) * .pi / 180
            let rotation = simd_quatf(angle: angle, axis: [0, 1, 0])
            action(rotation)

        case .scale:
            // Calcular escala a partir del movimiento vertical
            let scale = 1.0 + Float(delta.y) / 1000
            action(scale)
        }
    }
}
