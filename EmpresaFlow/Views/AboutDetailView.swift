import SwiftUI

/// Pantalla informativa solicitada por la práctica.
struct AboutDetailView: View {
    // CAMBIAR ESTOS 3 NOMBRES ANTES DE ENTREGAR.
    private let teamMembers = [
        "Integrante 1 — Nombre y apellidos",
        "Integrante 2 — Nombre y apellidos",
        "Integrante 3 — Nombre y apellidos"
    ]

    private let navy = Color(red: 0.08, green: 0.26, blue: 0.43)

    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                Image(systemName: "building.2.fill")
                    .font(.system(size: 54))
                    .foregroundStyle(.white)
                    .frame(width: 112, height: 112)
                    .background(navy, in: RoundedRectangle(cornerRadius: 28))
                    .accessibilityLabel("Logotipo de EmpresaFlow")

                VStack(spacing: 8) {
                    Text("EmpresaFlow")
                        .font(.largeTitle.bold())
                        .foregroundStyle(navy)
                    Text("Organiza tus proyectos y servicios desde el iPhone")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                GroupBox("Sobre el proyecto") {
                    Text("Aplicación iOS orientada a pequeñas empresas de construcción, limpieza, reformas y mantenimiento. Esta primera entrega presenta un catálogo de proyectos a partir de un JSON local; las funcionalidades de gestión completa se añadirán en fases posteriores.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 6)
                }

                GroupBox("Equipo de desarrollo") {
                    VStack(alignment: .leading, spacing: 14) {
                        ForEach(teamMembers, id: \.self) { member in
                            Label(member, systemImage: "person.crop.circle")
                                .font(.subheadline)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 6)
                }

                GroupBox("Tecnologías") {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Swift 6 y SwiftUI", systemImage: "chevron.left.forwardslash.chevron.right")
                        Label("Codable y archivo JSON local", systemImage: "curlybraces")
                        Label("Fotografías de Unsplash", systemImage: "photo")
                    }
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 6)
                }

                Text("UCAM · Aplicaciones para Dispositivos Móviles: iOS")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Acerca de")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack { AboutDetailView() }
}
