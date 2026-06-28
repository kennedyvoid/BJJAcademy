import Foundation

enum PositionData {
    

    private struct TechniqueSeed {
        let belts: Set<Belt>
        let name: String
        let category: String
        let points: Int?
        let imageName: String
        let summary: String
        let details: [String]
    }

    private static let allBelts = Set(Belt.allCases)
    private static let blueUp: Set<Belt> = [.blue, .purple, .brown, .black]
    private static let purpleUp: Set<Belt> = [.purple, .brown, .black]
    private static let brownUp: Set<Belt> = [.brown, .black]

    private static let scoringDetails = [
        "Precisa haver controle real e estabilização por aproximadamente 3 segundos.",
        "Tentativa, transição incompleta ou posição sem domínio normalmente não pontua.",
        "A regra do evento pode variar por idade, categoria, Gi/No-Gi e edital."
    ]

    private static let seeds: [TechniqueSeed] = [
        // Pontuação principal — base de competição, válida para todas as faixas adultas no Gi quando executada corretamente.
        .init(belts: allBelts, name: "Queda", category: "Pontuação", points: 2, imageName: "queda_basica", summary: "Levar o adversário ao chão e terminar por cima com controle.", details: ["Começa normalmente com ambos em pé.", "O atleta que derruba precisa consolidar controle após a queda."] + scoringDetails),
        .init(belts: allBelts, name: "Raspagem", category: "Pontuação", points: 2, imageName: "raspagem", summary: "Inverter a posição a partir da guarda ou meia-guarda e estabilizar por cima.", details: ["A ação precisa iniciar com controle por baixo em guarda/meia-guarda.", "A pontuação vem quando você vira e estabiliza por cima."] + scoringDetails),
        .init(belts: allBelts, name: "Joelho na barriga", category: "Pontuação", points: 2, imageName: "joelho_barriga", summary: "Controle com o joelho no tronco do adversário e postura dominante.", details: ["Um joelho pressiona abdômen, peito ou costela.", "A outra perna deve ficar com o pé apoiado, demonstrando domínio."] + scoringDetails),
        .init(belts: allBelts, name: "Passagem de guarda", category: "Pontuação", points: 3, imageName: "passagem_guarda", summary: "Superar as pernas do adversário e consolidar controle dominante.", details: ["A guarda precisa ser vencida de forma clara.", "Pode terminar em controle lateral, norte-sul, joelho na barriga ou montada."] + scoringDetails),
        .init(belts: allBelts, name: "Montada", category: "Pontuação", points: 4, imageName: "montada", summary: "Controle sentado sobre o tronco do adversário, impedindo reposição de guarda.", details: ["O atleta fica por cima, voltado para a cabeça do adversário.", "Precisa estabilizar sem que o adversário recupere meia-guarda ou guarda."] + scoringDetails),
        .init(belts: allBelts, name: "Pegada pelas costas", category: "Pontuação", points: 4, imageName: "costas", summary: "Controle das costas com domínio válido do tronco e ganchos/controle aceito.", details: ["Controle o tronco por trás.", "A pontuação depende do controle correto das costas conforme regra."] + scoringDetails),
        .init(belts: allBelts, name: "Montada pelas costas", category: "Pontuação", points: 4, imageName: "back_mount", summary: "Controle dominante nas costas do adversário.", details: ["Posição de domínio por trás.", "Pontua quando há controle claro e estabilização."] + scoringDetails),

        // Posições/controles permitidos para branca e demais faixas.
        .init(belts: allBelts, name: "Guarda fechada", category: "Controle", points: nil, imageName: "guarda_fechada", summary: "Controle por baixo com as pernas fechadas ao redor do adversário.", details: ["Não pontua sozinha.", "Serve para controlar postura, raspar ou atacar finalizações permitidas."]),
        .init(belts: allBelts, name: "Guarda aberta", category: "Controle", points: nil, imageName: "guarda_aberta", summary: "Controle de distância usando pernas, ganchos e pegadas.", details: ["Não pontua sozinha.", "Pode gerar raspagem, reposição de guarda ou ataque permitido."]),
        .init(belts: allBelts, name: "Meia-guarda", category: "Controle", points: nil, imageName: "meia_guarda", summary: "Controle de uma perna do adversário por baixo.", details: ["Não pontua sozinha.", "Base importante para defesa, raspagem e recuperação."]),
        .init(belts: allBelts, name: "Controle lateral", category: "Controle", points: nil, imageName: "controle_lateral", summary: "Controle por cima após vencer as pernas do adversário.", details: ["O controle lateral não dá pontos isolados.", "A pontuação normalmente vem da passagem de guarda."]),
        .init(belts: allBelts, name: "Norte-sul", category: "Controle", points: nil, imageName: "norte_sul", summary: "Controle por cima com orientação cabeça-cabeça.", details: ["Pode confirmar passagem e transições.", "Use pressão e controle de quadril para impedir a fuga."]),
        .init(belts: allBelts, name: "Armlock reto", category: "Finalização", points: nil, imageName: "armlock", summary: "Ataque reto no cotovelo, comum da guarda ou montada.", details: ["Finalização básica permitida quando aplicada sem torção proibida.", "Aplique de forma progressiva e segura."]),
        .init(belts: allBelts, name: "Americana", category: "Finalização", points: nil, imageName: "americana", summary: "Ataque de ombro a partir de controle lateral ou montada.", details: ["Finalização clássica de braço.", "Evite movimentos bruscos e respeite a categoria."]),
        .init(belts: allBelts, name: "Estrangulamento de gola", category: "Finalização", points: nil, imageName: "guarda_fechada", summary: "Estrangulamento usando gola do kimono.", details: ["Ataque básico no Gi.", "Não deve envolver torção cervical proibida."]),
        .init(belts: allBelts, name: "Mata-leão sem cervical", category: "Finalização", points: nil, imageName: "mata_leao", summary: "Estrangulamento pelas costas sem pressão de torção na cervical.", details: ["Controle as costas antes de atacar.", "Não combine com neck crank."]),

        // Azul acima — repertório ampliado.
        .init(belts: blueUp, name: "Triângulo", category: "Finalização", points: nil, imageName: "triangulo", summary: "Estrangulamento usando as pernas a partir da guarda ou transições.", details: ["Ataque comum em faixas coloridas adultas.", "Evite variações que puxem a cabeça de forma proibida em categorias restritas."]),
        .init(belts: blueUp, name: "Omoplata", category: "Finalização", points: nil, imageName: "omoplata", summary: "Ataque de ombro usando a perna como alavanca.", details: ["Muito comum da guarda aberta ou fechada.", "Controle quadril e postura para evitar fuga."]),
        .init(belts: blueUp, name: "Guilhotina frontal", category: "Finalização", points: nil, imageName: "guarda_aberta", summary: "Estrangulamento frontal aplicado sem torção cervical proibida.", details: ["Deve atacar como estrangulamento, não como crank cervical.", "Ajuste a pegada com segurança."]),
        .init(belts: blueUp, name: "Ezequiel", category: "Finalização", points: nil, imageName: "controle_lateral", summary: "Estrangulamento usando manga e antebraço.", details: ["Comum da montada ou controle por cima.", "Aplique como estrangulamento controlado."]),
        .init(belts: blueUp, name: "Chave de pé reta", category: "Finalização de perna", points: nil, imageName: "meia_guarda", summary: "Ataque reto no tornozelo/pé, sem torção lateral de joelho.", details: ["Evite torção do joelho.", "Heel hook e reaping seguem restritos no Gi."]),
        .init(belts: blueUp, name: "Chave de punho", category: "Finalização", points: nil, imageName: "americana", summary: "Ataque de punho permitido em faixas coloridas adultas conforme regulamento.", details: ["Não é recomendada para iniciantes.", "Use controle e progressão."]),

        // Roxa acima — transições avançadas, sem liberar golpes proibidos de perna.
        .init(belts: purpleUp, name: "Berimbolo", category: "Transição", points: nil, imageName: "sistema_transicoes", summary: "Inversão para buscar costas ou raspagem.", details: ["Não pontua sozinho.", "Pontua quando vira raspagem ou costas estabilizadas."]),
        .init(belts: purpleUp, name: "Guarda laçada / Lapel guard", category: "Controle", points: nil, imageName: "guarda_aberta", summary: "Uso da lapela para controlar distância, postura e entradas.", details: ["Não pontua sozinha.", "Pode gerar raspagem, passagem ou ataque permitido."]),
        .init(belts: purpleUp, name: "X-guard", category: "Controle", points: nil, imageName: "meia_guarda", summary: "Guarda com ganchos por baixo para desequilibrar e raspar.", details: ["Pontua quando resulta em raspagem estabilizada.", "Controle joelho e quadril do adversário."]),
        .init(belts: purpleUp, name: "Toreando", category: "Passagem", points: 3, imageName: "toreando", summary: "Passagem dinâmica controlando pernas e ângulo.", details: ["Pontua como passagem quando supera a guarda e estabiliza.", "Precisa consolidar controle após vencer as pernas."] + scoringDetails),

        // Marrom/preta — repertório avançado permitido conforme regra e modalidade.
        .init(belts: brownUp, name: "Toe hold", category: "Finalização de perna", points: nil, imageName: "meia_guarda", summary: "Ataque de torção no pé permitido apenas em faixas avançadas conforme regra.", details: ["Restrito para faixas inferiores.", "Não confundir com heel hook."]),
        .init(belts: brownUp, name: "Knee bar", category: "Finalização de perna", points: nil, imageName: "meia_guarda", summary: "Ataque reto no joelho, permitido em faixas avançadas conforme regra.", details: ["Restrito para faixas inferiores.", "Controle quadril antes de estender."]),
        .init(belts: brownUp, name: "Calf slicer", category: "Finalização de perna", points: nil, imageName: "meia_guarda", summary: "Compressão de panturrilha permitida apenas em faixas avançadas conforme regra.", details: ["Restrito para faixas inferiores.", "Aplicação exige extremo controle."]),
        .init(belts: brownUp, name: "Biceps slicer", category: "Finalização", points: nil, imageName: "armlock", summary: "Compressão de bíceps permitida apenas em faixas avançadas conforme regra.", details: ["Restrito para faixas inferiores.", "Use somente em categoria permitida."])
    ]

    static let all: [Position] = Belt.allCases.flatMap { belt in
        seeds.filter { $0.belts.contains(belt) }.map { seed in
            Position(
                id: "\(belt.rawValue)-\(seed.name)".normalizedID,
                belt: belt,
                name: seed.name,
                category: seed.category,
                points: seed.points,
                allowed: true,
                imageName: seed.imageName,
                imageCredit: "",
                summary: summaryForBelt(belt, seed.summary),
                details: seed.details
            )
        }
    }

    static func positions(for belt: Belt) -> [Position] {
        all.filter { $0.belt == belt }
    }

    static func forbidden(for belt: Belt) -> [String] {
        switch belt {
        case .white:
            return ["Heel hook", "Knee reaping", "Toe hold", "Knee bar", "Calf slicer", "Biceps slicer", "Chave de punho", "Chave de cervical / neck crank", "Bate-estaca", "Tesoura / kani basami", "Torções de joelho", "Ataques avançados de perna"]
        case .blue:
            return ["Heel hook", "Knee reaping", "Toe hold", "Knee bar", "Calf slicer", "Biceps slicer", "Chave de cervical / neck crank", "Bate-estaca", "Tesoura / kani basami"]
        case .purple:
            return ["Heel hook", "Knee reaping", "Toe hold", "Knee bar", "Calf slicer", "Biceps slicer", "Chave de cervical / neck crank", "Bate-estaca", "Tesoura / kani basami"]
        case .brown, .black:
            return ["Heel hook no Gi com kimono/Gi tradicional: valide modalidade e edital", "Knee reaping segue restrições do regulamento", "Chave de cervical / neck crank", "Bate-estaca", "Tesoura / kani basami", "Qualquer golpe com risco de lesão fora do controle"]
        }
    }

    static func search(_ text: String) -> [Position] {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return all }
        return all.filter { position in
            position.name.localizedCaseInsensitiveContains(text) ||
            position.category.localizedCaseInsensitiveContains(text) ||
            position.belt.rawValue.localizedCaseInsensitiveContains(text)
        }
    }

    private static func summaryForBelt(_ belt: Belt, _ base: String) -> String {
        switch belt {
        case .white: return base + " Incluída aqui por ser compatível com repertório permitido para faixa branca adulta no Gi."
        case .blue: return base + " Incluída para faixa azul adulta respeitando restrições de golpes perigosos."
        case .purple: return base + " Incluída para faixa roxa adulta, com progressão técnica intermediária."
        case .brown: return base + " Incluída para faixa marrom adulta, incluindo parte do repertório avançado."
        case .black: return base + " Incluída para faixa preta adulta, com atenção fina à modalidade e edital."
        }
    }
}

private extension String {
    var normalizedID: String {
        folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
            .replacingOccurrences(of: " / ", with: "-")
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: "/", with: "-")
            .replacingOccurrences(of: "--", with: "-")
    }
}
