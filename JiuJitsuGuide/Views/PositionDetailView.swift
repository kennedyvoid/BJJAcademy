import SwiftUI

struct PositionDetailView: View {
    let position: Position
    @AppStorage("favoritePositionIds") private var rawFavorites = ""

    private var isFavorite: Bool {
        FavoriteStore.ids(from: rawFavorites).contains(position.id)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 18) {
                GeometryReader { proxy in
                    let width = proxy.size.width
                    RemotePositionImageView(
                        position: position,
                        height: min(max(width * 0.56, 180), 260),
                        cornerRadius: 22
                    )
                    .shadow(radius: 3)
                }
                .frame(height: imageContainerHeight)

                VStack(alignment: .leading, spacing: 8) {
                    Text(position.name)
                        .font(.title.bold())
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(position.summary)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .lineSpacing(3)
                        .fixedSize(horizontal: false, vertical: true)
                }

                LazyVGrid(columns: infoColumns, spacing: 10) {
                    InfoPill(title: "Faixa", value: position.belt.shortName)
                    InfoPill(title: "Pontos", value: position.points.map { "\($0)" } ?? "—")
                    InfoPill(title: "Status", value: "Permitido")
                }

                DetailSection(title: "Critérios") {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(position.details.enumerated()), id: \.offset) { index, detail in
                            HStack(alignment: .top, spacing: 10) {
                                Text("\(index + 1)")
                                    .font(.caption.bold())
                                    .frame(width: 24, height: 24)
                                    .background(.thinMaterial)
                                    .clipShape(Circle())
                                    .accessibilityHidden(true)

                                Text(detail)
                                    .font(.callout)
                                    .lineSpacing(3)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: 620, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 28)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .navigationTitle(position.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .font(.title3)
                }
                .accessibilityLabel(isFavorite ? "Remover dos favoritos" : "Adicionar aos favoritos")
            }
        }
    }

    private var imageContainerHeight: CGFloat {
        // Altura segura para iPhone SE, Mini, padrão e Pro Max.
        245
    }

    private var infoColumns: [GridItem] {
        [GridItem(.adaptive(minimum: 96, maximum: 180), spacing: 10)]
    }

    private func toggleFavorite() {
        var ids = FavoriteStore.ids(from: rawFavorites)
        if ids.contains(position.id) {
            ids.remove(position.id)
        } else {
            ids.insert(position.id)
        }
        rawFavorites = FavoriteStore.raw(from: ids)
    }
}

struct DetailSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3.bold())
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

struct InfoPill: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.75)

            Text(value)
                .font(.subheadline.bold())
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity, minHeight: 66)
        .padding(.horizontal, 8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}
