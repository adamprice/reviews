import UIKit
import CoreLocation

@MainActor
protocol BusinessDetailsDisplayable {
    var reviewViewModels: [ReviewViewModel] { get }
    var categoryViewModels: [CategoryLabelViewModel] { get }
    var businessID: String { get }
    var name: String { get }
    var address: [String] { get }
    var coordinates: CLLocationCoordinate2D { get }
    var city: String { get }
    var state: String  { get }
    var price: String? { get }
    var rating: Double { get }
    var reviewCount: Int { get }
    var openNow: Bool? { get }
    var openUntil: String? { get }
}

protocol BusinessActions {
    func callBusiness()
    func viewOnYelp()
}

protocol AdditionalDetailsFetchable {
    func loadAdditionalBusinessData(id: String) async throws
    func loadBusiness(id: String) async throws
    func loadReviews(id: String) async throws
}

@MainActor
@Observable 
final class BusinessDetailsViewModel {

    enum Errors: Error {
        case failedToDecodeAdditionalBusinessData(decodingError: Error)
        case failedToDecodeReviews(decodingError: Error)
        case networkRequestFailed(requestError: Error)
        case failedToReadResponse
        case badHTTPStatusCode(statusCode: Int)
    }

    private let business: Business
    private let client: URLRequestClient
    private let openURLHandler: OpenURLHandler
    private let dateProvider: DateProvidable

    private var additionalBusinessDetails: AdditionalBusinessDetails?
    private var reviews: [Review] = []

    private(set) var imageURLs: [URL] = []

    init(business: Business,
         client: URLRequestClient = URLSession.shared,
         openURLHandler: OpenURLHandler? = nil,
         dateProvider: DateProvidable = DateProvider()) {
        self.business = business
        self.client = client
        self.openURLHandler = openURLHandler ?? UIApplication.shared
        self.dateProvider = dateProvider
    }
}

extension BusinessDetailsViewModel: BusinessActions {
    func callBusiness() {
        openURLHandler.open(URL(string: "tel://\(business.phone)")!, options: [:], completionHandler: nil)
    }

    func viewOnYelp() {
        openURLHandler.open(business.url, options: [:], completionHandler: nil)
    }
}

extension BusinessDetailsViewModel: AdditionalDetailsFetchable {
    func loadAdditionalBusinessData(id: String) async throws {
        try await loadBusiness(id: id)
        try await loadReviews(id: id)
    }

    func loadBusiness(id: String) async throws {
        let data = try await loadRequestData(endpoint: .business(id: id))

        do {
            let decoder = JSONDecoder()
            let detailedBusiness = try decoder.decode(AdditionalBusinessDetails.self, from: data)
            self.additionalBusinessDetails = detailedBusiness
            self.imageURLs = detailedBusiness.photos
        } catch {
            throw Errors.failedToDecodeAdditionalBusinessData(decodingError: error)
        }
    }

    func loadReviews(id: String) async throws {
        let data = try await loadRequestData(endpoint: .reviews(business: id))

        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(ReviewsResponse.self, from: data)
            self.reviews = response.reviews
        } catch {
            throw Errors.failedToDecodeReviews(decodingError: error)
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
            throw Errors.networkRequestFailed(requestError: error)
        }
    }
}

extension BusinessDetailsViewModel: BusinessDetailsDisplayable {
    var reviewViewModels: [ReviewViewModel] {
        reviews.map { ReviewViewModel(review: $0) }
    }

    var categoryViewModels: [CategoryLabelViewModel] {
        business.categories.map { CategoryLabelViewModel(businessCategory: $0) }
    }

    var businessID: String {
        business.id
    }

    var name: String {
        business.name
    }

    var address: [String] {
        business.location.displayAddress
    }

    var coordinates: CLLocationCoordinate2D {
        business.coordinates.coreLocationCoordinate
    }

    var city: String {
        business.location.city
    }

    var state: String {
        business.location.state
    }

    var price: String? {
        business.price
    }

    var rating: Double {
        business.rating
    }

    var reviewCount: Int {
        business.reviewCount
    }

    var openNow: Bool? {
        additionalBusinessDetails?.hours.first?.openNow
    }

    var openUntil: String? {
        let currentDay = dateProvider.dayOfWeekStartingAtZero
        let hours = additionalBusinessDetails?.hours.first?.days.first { $0.day == currentDay }

        if var closingTime = hours?.end {
            closingTime.insert(":", at: closingTime.index(closingTime.startIndex, offsetBy: 2))
            return closingTime
        } else {
            return nil
        }
    }
}
