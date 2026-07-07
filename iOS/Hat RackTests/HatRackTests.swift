import XCTest
@testable import HatRack

@MainActor
final class HatRackTests: XCTestCase {
    func testSeedDataLoadsBelowFreeLimit() {
        let store = Store()
        XCTAssertLessThan(store.items.count, Store.freeLimit)
    }

    func testAddIncreasesCount() {
        let store = Store()
        let before = store.items.count
        store.add(Hat(name: "Test Item", brand: "x", size: "x", era: "x"))
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testDeleteRemovesItem() {
        let store = Store()
        let item = Hat(name: "Deletable", brand: "x", size: "x", era: "x")
        store.add(item)
        store.delete(item)
        XCTAssertFalse(store.items.contains(where: { $0.id == item.id }))
    }

    func testCanAddMoreWhenBelowLimitAndNotPro() {
        let store = Store()
        store.isPro = false
        XCTAssertTrue(store.items.count < Store.freeLimit)
        XCTAssertTrue(store.canAddMore)
    }

    func testCannotAddMoreAtLimitWhenNotPro() {
        let store = Store()
        store.isPro = false
        while store.items.count < Store.freeLimit {
            store.add(Hat(name: "Filler", brand: "x", size: "x", era: "x"))
        }
        XCTAssertFalse(store.canAddMore)
    }

    func testCanAddMoreWhenProEvenAtLimit() {
        let store = Store()
        store.isPro = true
        while store.items.count < Store.freeLimit {
            store.add(Hat(name: "Filler", brand: "x", size: "x", era: "x"))
        }
        XCTAssertTrue(store.canAddMore)
    }

    func testUpdateModifiesExistingItem() {
        let store = Store()
        var item = Hat(name: "Original", brand: "x", size: "x", era: "x")
        store.add(item)
        item.name = "Renamed"
        store.update(item)
        XCTAssertEqual(store.items.first(where: { $0.id == item.id })?.name, "Renamed")
    }
}
