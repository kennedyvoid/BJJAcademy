import SwiftUI

enum Belt: String, CaseIterable, Identifiable, Codable {
    case white = "Faixa Branca"
    case blue = "Faixa Azul"
    case purple = "Faixa Roxa"
    case brown = "Faixa Marrom"
    case black = "Faixa Preta"

    var id: String { rawValue }

    var shortName: String {
        switch self {
        case .white: return "Branca"
        case .blue: return "Azul"
        case .purple: return "Roxa"
        case .brown: return "Marrom"
        case .black: return "Preta"
        }
    }

    var subtitle: String {
        switch self {
        case .white: return "Fundamentos permitidos para competir com segurança"
        case .blue: return "Ataques básicos ampliados e controle técnico"
        case .purple: return "Transições, estratégia e repertório intermediário"
        case .brown: return "Finalizações avançadas conforme regulamento"
        case .black: return "Sistema completo com validação por modalidade"
        }
    }

    var theme: Color {
        switch self {
        case .white: return .gray
        case .blue: return .blue
        case .purple: return .purple
        case .brown: return .brown
        case .black: return .black
        }
    }
}
