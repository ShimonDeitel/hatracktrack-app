import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published private(set) var items: [Hat] = []
    @Published var isPro: Bool = false

    static let freeLimit = 20

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("hatracktrack_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Hat) {
        items.append(item)
        save()
    }

    func update(_ item: Hat) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Hat) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Hat].self, from: data) {
            items = decoded
        } else {
            items = [
        Hat(name: "Fedora", brand: "Stetson", size: "7 1/4", era: "1950s"),
        Hat(name: "Snapback", brand: "New Era", size: "M/L", era: "2010s"),
        Hat(name: "Panama Hat", brand: "Montecristi", size: "L", era: "1980s"),
        Hat(name: "Flat Cap", brand: "Kangol", size: "M", era: "1970s"),
        Hat(name: "Bowler", brand: "Christys", size: "7", era: "1920s")
            ]
            save()
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }
}
