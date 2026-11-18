import SwiftUI

/// Pantalla principal. Los datos son inyectados por la Persona 3 tras leer projects.json.
/// Esta vista NO lee archivos ni necesita conocer JSONLoader.
struct ProjectListView: View {
    let projects: [Project]

    @State private var searchText = ""
    @State private var selectedCategory = "Todas"

    private let navy = Color(red: 0.08, green: 0.26, blue: 0.43)

    private var categories: [String] {
        ["Todas"] + Set(projects.map(\.category)).sorted()
    }

    private var filteredProjects: [Project] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        return projects.filter { project in
            let matchesCategory = selectedCategory == "Todas" || project.category == selectedCategory
            let matchesText = query.isEmpty || [
                project.title,
                project.category,
                project.location,
                project.description
            ].contains { $0.localizedStandardContains(query) }
            return matchesCategory && matchesText
        }
    }

    private var activeProjectsCount: Int {
        projects.filter { $0.status == "En curso" }.count
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 12) {
                        SummaryTile(title: "Proyectos",
                                    value: "\(projects.count)",
                                    symbol: "folder.fill",
                                    tint: navy)
                        SummaryTile(title: "En curso",
                                    value: "\(activeProjectsCount)",
                                    symbol: "checkmark.circle.fill",
                                    tint: .green)
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }

                if selectedCategory != "Todas" {
                    Section {
                        HStack {
                            Label("Categoría: \(selectedCategory)", systemImage: "line.3.horizontal.decrease.circle")
                                .font(.subheadline)
                            Spacer()
                            Button("Quitar filtro") { selectedCategory = "Todas" }
                                .font(.caption)
                        }
                    }
                }

                Section {
                    if filteredProjects.isEmpty {
                        ContentUnavailableView(
                            "No hay proyectos",
                            systemImage: "tray",
                            description: Text("Prueba otra búsqueda o cambia la categoría.")
                        )
                        .listRowBackground(Color.clear)
                    } else {
                        ForEach(filteredProjects) { project in
                            NavigationLink {
                                ProjectDetailView(project: project)
                            } label: {
                                ProjectRowView(project: project)
                            }
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                            .listRowSeparator(.hidden)
                        }
                    }
                } header: {
                    HStack {
                        Text("Servicios y proyectos")
                        Spacer()
                        Text("\(filteredProjects.count)")
                    }
                } footer: {
                    Text("Selecciona un proyecto para consultar sus datos y actuaciones.")
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("EmpresaFlow")
            .searchable(text: $searchText, prompt: "Buscar nombre, sector o municipio")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Categoría", selection: $selectedCategory) {
                            ForEach(categories, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundStyle(navy)
                    }
                    .accessibilityLabel("Filtrar proyectos por categoría")
                }

                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AboutDetailView()
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(navy)
                    }
                    .accessibilityLabel("Acerca de EmpresaFlow")
                }
            }
        }
    }
}

private struct SummaryTile: View {
    let title: String
    let value: String
    let symbol: String
    let tint: Color

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: symbol)
                .font(.title3)
                .foregroundStyle(tint)
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 3) {
                Text(value)
                    .font(.title2.bold())
                    .monospacedDigit()
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview("Sin proyectos") {
    ProjectListView(projects: [])
}
