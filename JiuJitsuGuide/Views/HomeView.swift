import SwiftUI

struct HomeView: View {
    @AppStorage("appTheme") private var appTheme = AppTheme.system.rawValue

    private var isDark: Bool { appTheme == AppTheme.dark.rawValue }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header

                VStack(alignment: .leading, spacing: 12) {
                    Text("Escolha a faixa")
                        .font(.title2.bold())
                        .padding(.horizontal)

                    ForEach(Belt.allCases) { belt in
                        NavigationLink {
                            BeltPositionsView(belt: belt)
                        } label: {
                            BeltCardView(belt: belt)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical, 18)
        }
        .navigationTitle("BJJ Academy")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        appTheme = isDark ? AppTheme.light.rawValue : AppTheme.dark.rawValue
                    }
                } label: {
                    Image(systemName: isDark ? "sun.max.fill" : "moon.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 34, height: 34)
                        .background(.thinMaterial, in: Circle())
                }
                .accessibilityLabel(isDark ? "Ativar tela clara" : "Ativar tela escura")
            }
        }
    }

    private var header: some View {
        VStack(spacing: 14) {
            AppLogoView(size: 92)
            Text("BJJ Academy")
                .font(.largeTitle.bold())
            Text("Guia de posições permitidas por faixa, pontuação e regras rápidas para campeonato.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 28)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 10)
    }
}
