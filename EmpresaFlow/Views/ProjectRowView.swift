import SwiftUI

/// Cada proyecto se presenta con una celda independiente y reutilizable.
struct ProjectRowView: View {
    let project: Project

    private let navy = Color(red: 0.08, green: 0.26, blue: 0.43)

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ProjectImageView(
                url: project.mainImageURL,
                height: 116,
                width: 100,
                cornerRadius: 12
            )

            VStack(alignment: .leading, spacing: 7) {
                Text(project.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)

                Text(project.category)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                Label(project.location, systemImage: "mappin.circle")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                HStack(spacing: 10) {
                    Label(
                        "\(project.workedHours.formatted(.number.precision(.fractionLength(0...1)))) h",
                        systemImage: "clock"
                    )
                    Label("\(project.employeeCount)", systemImage: "person.2")
                }
                .font(.caption2)
                .foregroundStyle(.secondary)

                HStack(alignment: .center, spacing: 6) {
                    Text(project.estimatedCost, format: .currency(code: "EUR"))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(navy)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)

                    Spacer(minLength: 0)
                    ProjectStatusBadge(status: project.status)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 16))
        .accessibilityElement(children: .combine)
    }
}

/// Se reutiliza en la fila y en el detalle; los colores dependen del estado real del JSON.
struct ProjectStatusBadge: View {
    let status: String

    var body: some View {
        Text(status)
            .font(.system(size: 10, weight: .semibold))
            .foregroundStyle(statusColor)
            .padding(.horizontal, 7)
            .padding(.vertical, 5)
            .background(statusColor.opacity(0.12), in: Capsule())
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
    }

    private var statusColor: Color {
        switch status.lowercased() {
        case "en curso":  return .green
        case "pendiente": return .orange
        case "finalizado": return .blue
        case "pausado": return .secondary
        default: return .secondary
        }
    }
}
