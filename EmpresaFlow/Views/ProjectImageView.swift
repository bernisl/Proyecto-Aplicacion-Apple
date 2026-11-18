import SwiftUI

/// Componente visual compartido por la lista y el detalle.
/// Las imágenes se consultan desde las URLs de Unsplash guardadas en projects.json.
/// Si no hay internet, la URL falla o la imagen tarda, la app no se bloquea.
struct ProjectImageView: View {
    let url: URL
    var height: CGFloat = 100
    var width: CGFloat? = nil
    var cornerRadius: CGFloat = 14

    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        placeholder
                        ProgressView()
                            .tint(.white)
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    placeholder
                @unknown default:
                    placeholder
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .accessibilityLabel("Fotografía del proyecto")
    }

    private var placeholder: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.08, green: 0.22, blue: 0.36),
                         Color(red: 0.19, green: 0.43, blue: 0.60)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Image(systemName: "building.2.fill")
                .font(.system(size: 30, weight: .medium))
                .foregroundStyle(.white.opacity(0.85))
        }
    }
}

#Preview("Sin conexión") {
    ProjectImageView(url: URL(fileURLWithPath: "/imagen-inexistente"),
                     height: 180,
                     width: 300)
}
