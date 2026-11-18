import SwiftUI

/// Recibe el proyecto seleccionado desde ProjectListView mediante NavigationLink.
/// No vuelve a cargar datos: la ficha utiliza el Project recibido como parámetro.
struct ProjectDetailView: View {
    let project: Project

    private let navy = Color(red: 0.08, green: 0.26, blue: 0.43)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ProjectImageView(
                    url: project.mainImageURL,
                    height: 245,
                    cornerRadius: 0
                )

                VStack(alignment: .leading, spacing: 20) {
                    header
                    descriptionSection
                    metricsSection
                    informationSection
                    tagsSection
                    gallerySection
                    notesSection
                    photoSourceSection
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 28)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Detalle del proyecto")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(project.title)
                .font(.largeTitle.bold())
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 9) {
                Label(project.category, systemImage: "square.grid.2x2")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                ProjectStatusBadge(status: project.status)
            }

            Label(project.location, systemImage: "mappin.and.ellipse")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var descriptionSection: some View {
        GroupBox {
            Text(project.description)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
        } label: {
            Label("Descripción", systemImage: "text.alignleft")
        }
    }

    private var metricsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Resumen del servicio")
                .font(.title3.bold())

            HStack(spacing: 12) {
                DetailMetricCard(label: "Horas trabajadas",
                                 value: project.workedHours.formatted(.number.precision(.fractionLength(0...1))) + " h",
                                 symbol: "clock.fill")
                DetailMetricCard(label: "Trabajadores",
                                 value: "\(project.employeeCount)",
                                 symbol: "person.2.fill")
            }

            GroupBox {
                HStack(spacing: 12) {
                    Label("Coste estimado", systemImage: "eurosign.circle")
                        .foregroundStyle(.secondary)
                    Spacer(minLength: 0)
                    Text(project.estimatedCost, format: .currency(code: "EUR"))
                        .font(.headline)
                        .foregroundStyle(navy)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                }
            }
        }
    }

    private var informationSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 12) {
                LabeledContent("Fecha de creación") {
                    Text(project.createdAt, style: .date)
                }
                Divider()
                LabeledContent("Municipio") {
                    Text(project.location)
                }
                Divider()
                LabeledContent("Coordenadas") {
                    Text(String(format: "%.4f, %.4f", project.latitude, project.longitude))
                        .font(.caption.monospacedDigit())
                }
            }
        } label: {
            Label("Datos del proyecto", systemImage: "info.square")
        }
    }

    @ViewBuilder
    private var tagsSection: some View {
        if !project.tags.isEmpty {
            VStack(alignment: .leading, spacing: 10) {
                Text("Etiquetas")
                    .font(.title3.bold())
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(project.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .foregroundStyle(navy)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 7)
                                .background(navy.opacity(0.08), in: Capsule())
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }

    @ViewBuilder
    private var gallerySection: some View {
        if !project.imageURL.isEmpty {
            VStack(alignment: .leading, spacing: 10) {
                Text("Galería de fotografías")
                    .font(.title3.bold())
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(project.imageURL, id: \.self) { url in
                            ProjectImageView(url: url,
                                             height: 120,
                                             width: 165,
                                             cornerRadius: 12)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }

    @ViewBuilder
    private var notesSection: some View {
        if !project.notes.isEmpty {
            VStack(alignment: .leading, spacing: 10) {
                Text("Historial de actuaciones")
                    .font(.title3.bold())

                ForEach(project.notes.sorted { $0.date > $1.date }) { note in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Label(note.author, systemImage: "person.crop.circle")
                                .font(.subheadline.weight(.semibold))
                                .lineLimit(1)
                            Spacer(minLength: 6)
                            Text(note.date, style: .date)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Text(note.comment)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Prioridad: \(note.priorityLabel)")
                            .font(.caption.weight(.medium))
                            .foregroundStyle(note.priority >= 4 ? Color.orange : Color.secondary)
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemGroupedBackground),
                                in: RoundedRectangle(cornerRadius: 14))
                }
            }
        }
    }

    private var photoSourceSection: some View {
        Link(destination: project.webURL) {
            Label("Ver fotografía original en Unsplash", systemImage: "arrow.up.right.square")
                .font(.footnote)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct DetailMetricCard: View {
    let label: String
    let value: String
    let symbol: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: symbol)
                .foregroundStyle(Color(red: 0.08, green: 0.26, blue: 0.43))
            Text(value)
                .font(.title2.bold())
                .minimumScaleFactor(0.7)
                .lineLimit(1)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 14))
    }
}
