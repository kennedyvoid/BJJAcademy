import SwiftUI

struct AboutView: View {
    var body: some View {
        List {
            Section {
                HStack(spacing: 16) {
                    AppLogoView(size: 72)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("BJJ Academy")
                            .font(.title2.bold())
                        Text("Versão 1.0")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }

            Section("O app") {
                Text("Guia de posições permitidas por faixa para competição, com pontuação, técnicas proibidas, busca e favoritos.")
                Text("Desenvolvido por Kennedy Santos Da Silva com intuito de estudar as tecnicas de combate de forma mais detalhada e eficiente do jiu-jitsu.")
            }

            Section("Aviso") {
                Text("Este aplicativo é material de estudo e não substitui o livro de regras oficial nem o edital do campeonato.")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Sobre")
    }
}
