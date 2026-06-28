import SwiftUI

struct RemoteMediaImageView: View {
    let imageURL: String
    let fallbackImageName: String

    var body: some View {
        if let url = URL(string: imageURL) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView("Carregando imagem real...")
                        .frame(maxWidth: .infinity, minHeight: 240)
                        .background(.thinMaterial)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, minHeight: 260, maxHeight: 320)
                        .clipped()
                case .failure:
                    fallback
                @unknown default:
                    fallback
                }
            }
        } else {
            fallback
        }
    }

    private var fallback: some View {
        ZStack {
            Image(fallbackImageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, minHeight: 260, maxHeight: 320)
                .clipped()
                .opacity(0.35)

            VStack(spacing: 8) {
                Image(systemName: "wifi.slash")
                    .font(.largeTitle)
                Text("Não foi possível carregar a imagem real")
                    .font(.headline)
                Text("Verifique sua conexão com a internet.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
