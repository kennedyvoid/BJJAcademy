import Foundation

struct Position: Identifiable, Hashable, Codable {
    let id: String
    let belt: Belt
    let name: String
    let category: String
    let points: Int?
    let allowed: Bool
    let imageName: String
    let imageCredit: String
    let summary: String
    let details: [String]
}
