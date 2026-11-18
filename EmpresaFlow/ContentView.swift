import SwiftUI

/// Pantalla raíz: conecta el lector JSON local con la interfaz de Persona 2.
/// Persona 3 puede sustituir ProjectDataLoader por JSONLoader sin cambiar las vistas.
struct ContentView: View {
    @State private var projects: [Project] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Cargando proyectos…")
            } else if let errorMessage {
                ContentUnavailableView(
                    "No se pudieron cargar los proyectos",
                    systemImage: "exclamationmark.triangle",
                    description: Text(errorMessage)
                )
            } else {
                ProjectListView(projects: projects)
            }
        }
        .task {
            guard isLoading else { return }
            do {
                projects = try ProjectDataLoader.loadProjects()
            } catch {
                errorMessage = error.localizedDescription
                print("Error cargando projects.json: \(error)")
            }
            isLoading = false
        }
    }
}
