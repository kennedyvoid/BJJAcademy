import SwiftUI
import UIKit

struct RemotePositionImageView: View {
    let position: Position
    var height: CGFloat? = nil
    var cornerRadius: CGFloat = 18

    var body: some View {
        Group {
            if let uiImage = UIImage(named: position.imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                ImageMissingView(imageName: position.imageName)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}

struct ImageMissingView: View {
    let imageName: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.gray.opacity(0.18))
            VStack(spacing: 8) {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.system(size: 26, weight: .semibold))
                Text("Imagem não encontrada")
                    .font(.caption.bold())
                Text(imageName)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.center)
            .padding(8)
        }
    }
}
