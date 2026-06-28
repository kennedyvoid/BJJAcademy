import SwiftUI

struct RulesView: View {
    @State private var selectedTab: RulesTab = .scoring

    private let scoring = [
        ("Queda", "2 pontos"),
        ("Raspagem", "2 pontos"),
        ("Joelho na barriga", "2 pontos"),
        ("Passagem de guarda", "3 pontos"),
        ("Montada", "4 pontos"),
        ("Pegada pelas costas", "4 pontos")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Picker("Regras", selection: $selectedTab) {
                    ForEach(RulesTab.allCases) { tab in
                        Text(tab.rawValue).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                switch selectedTab {
                case .scoring:
                    scoringContent
                case .forbidden:
                    forbiddenContent
                }
            }
            .padding(.vertical, 12)
        }
        .navigationTitle("Regras")
    }

    private var scoringContent: some View {
        VStack(alignment: .leading, spacing: 14) {
            RulesSection(title: "Pontuação principal", systemImage: "star.circle.fill") {
                VStack(spacing: 10) {
                    ForEach(scoring, id: \.0) { item in
                        HStack(alignment: .firstTextBaseline) {
                            Text(item.0)
                                .font(.callout)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer(minLength: 12)
                            Text(item.1)
                                .font(.callout.bold())
                                .lineLimit(1)
                        }
                        .padding(12)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                }
            }

            RulesSection(title: "Critério", systemImage: "checkmark.seal.fill") {
                VStack(alignment: .leading, spacing: 12) {
                    RuleLabel("Controle e estabilização por aproximadamente 3 segundos.", icon: "timer")
                    RuleLabel("Tentativa sem domínio não deve ser tratada como pontuação consolidada.", icon: "exclamationmark.triangle")
                    RuleLabel("Cada campeonato pode ter edital próprio.", icon: "doc.text")
                }
            }
        }
        .padding(.horizontal)
    }

    private var forbiddenContent: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Proibidas por faixa")
                .font(.title2.bold())
                .padding(.horizontal)

            Text("Use esta aba para consultar rapidamente o que não deve aparecer como permitido naquela faixa.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)

            ForEach(Belt.allCases) { belt in
                DisclosureGroup {
                    VStack(spacing: 10) {
                        ForEach(PositionData.forbidden(for: belt), id: \.self) { move in
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: "xmark.octagon.fill")
                                    .foregroundStyle(.red)
                                    .font(.callout)
                                Text(move)
                                    .font(.callout)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer(minLength: 0)
                            }
                            .padding(12)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }
                    }
                    .padding(.top, 10)
                } label: {
                    HStack(spacing: 10) {
                        Circle()
                            .fill(belt.theme.opacity(belt == .white ? 0.25 : 0.75))
                            .frame(width: 14, height: 14)
                        Text(belt.rawValue)
                            .font(.headline)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                }
                .padding(14)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .padding(.horizontal)
            }
        }
    }
}

enum RulesTab: String, CaseIterable, Identifiable {
    case scoring = "Pontuação"
    case forbidden = "Proibidas"

    var id: String { rawValue }
}

struct RulesSection<Content: View>: View {
    let title: String
    let systemImage: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: systemImage)
                .font(.headline)
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

struct RuleLabel: View {
    let text: String
    let icon: String

    init(_ text: String, icon: String) {
        self.text = text
        self.icon = icon
    }

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(.secondary)
                .frame(width: 22)
            Text(text)
                .font(.callout)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
