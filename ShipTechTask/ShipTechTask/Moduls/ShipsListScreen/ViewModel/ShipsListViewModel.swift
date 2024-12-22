import Combine
import Foundation

final class ShipListViewModel {

    // MARK: - Properties

    @Published var ships: [Ship] = []
    @Published var isOfflineMode: Bool = false
    @Published var errorMessage: String?

    private let dataProvider: DataProvider
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }

    // MARK: - Fetch Ships

    func fetchShips() async {
        do {
            let fetchedShips = try await dataProvider.fetchShips(refreshFromAPI: true)
            ships = fetchedShips.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        } catch {
            errorMessage = "Failed to fetch ships."
        }
    }

    // MARK: - Delete Ship

    func deleteShip(by id: String) async {
        do {
            try await dataProvider.deleteShip(by: id)
            ships.removeAll { $0.id == id }
        } catch {
            errorMessage = "Failed to delete ship."
        }
    }
}
