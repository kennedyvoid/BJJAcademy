import SwiftUI

struct SettingsView: View {
    @AppStorage("appTheme") private var appTheme = AppTheme.system.rawValue

    var body: some View {
        Form {
            Section {
                HStack(spacing: 16) {
                    AppLogoView(size: 72)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("BJJ Academy")
                            .font(.title3.bold())
                        Text("Guia técnico por faixa")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }

            Section("Aparência") {
                Picker("Tema", selection: $appTheme) {
                    ForEach(AppTheme.allCases) { theme in
                        Text(theme.rawValue).tag(theme.rawValue)
                    }
                }
                .pickerStyle(.segmented)

                Text("Use Sistema para seguir o iPhone, Clara para fundo claro ou Escura para fundo escuro.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Ajustes")
    }
}
