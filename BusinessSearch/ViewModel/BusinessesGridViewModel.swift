import SwiftUI

protocol BusinessesFetcher {
    func loadBusinesses() async throws
}

protocol BusinessesSorter {
    func sortBusinesses(by option: BusinessSortOption)
}

enum BusinessSortOption: CaseIterable {
    case alphabetical
    case rating

    var label: String {
        switch self {
        case .alphabetical:
            return "Alphabetical"
        case .rating:
            return "Rating"
        }
    }

    var imageName: String {
        switch self {
        case .alphabetical:
            return "abc"
        case .rating:
            return "star.fill"
        }
    }
}

@MainActor
@Observable 
final class BusinessesGridViewModel {

    enum Errors: Error {
        case failedToDecodeBusinesses(decodingError: Error)
        case networkRequestFailed(requestError: Error)
        case failedToReadResponse
        case badHTTPStatusCode(statusCode: Int)
    }

    private let client: URLRequestClient

    var searchQuery: String
    var errorOccured: Bool = false

    private(set) var businesses: [BusinessViewModel] = []

    init(client: URLRequestClient = URLSession.shared, initialQuery: String = "Mexican") {
        self.client = client
        self.searchQuery = initialQuery
    }
}

extension BusinessesGridViewModel: BusinessesSorter {
    func sortBusinesses(by option: BusinessSortOption) {
        switch option {
        case .alphabetical:
            businesses.sort { $0.name < $1.name }
        case .rating:
            businesses.sort { $0.rating > $1.rating }
        }
    }
}

extension BusinessesGridViewModel: BusinessesFetcher {
    func loadBusinesses() async throws {
        errorOccured = false
        guard searchQuery.isEmpty == false else { return }
        let data = try await loadRequestData(endpoint: .search(for: searchQuery))

        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(BusinessesResponse.self, from: data)
            businesses = response.businesses.map { BusinessViewModel(business: $0) }
        } catch {
            errorOccured = true
            throw Errors.failedToDecodeBusinesses(decodingError: error)
        }
    }

    private func loadRequestData(endpoint: Endpoint) async throws -> Data {
        do {
            let response = try await self.client.request(endpoint)
            let responseData = response.0

            guard let httpResponse = response.1 as? HTTPURLResponse else {
                throw Errors.failedToReadResponse
            }

            switch httpResponse.statusCode {
            case 200...299:
                return responseData
            default:
                throw Errors.badHTTPStatusCode(statusCode: httpResponse.statusCode)
            }

        } catch {
            errorOccured = true
            throw Errors.networkRequestFailed(requestError: error)
        }
    }
}
