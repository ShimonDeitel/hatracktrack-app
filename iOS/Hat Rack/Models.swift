import Foundation

struct Hat: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var brand: String
    var size: String
    var era: String
    var dateAdded: Date = Date()
}
