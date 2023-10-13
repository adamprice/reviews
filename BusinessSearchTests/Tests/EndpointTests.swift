import XCTest

@testable import BusinessSearch

final class EndpointTests: XCTestCase {

    func testSearchEndpointIsConstructedCorrectly() throws {
        let searchTerm = "test_search"
        let searchLocation = "Cardiff"
        let endpoint: Endpoint = .search(for: searchTerm, location: searchLocation, limit: 10)
        XCTAssertEqual(endpoint.url.absoluteString,
                       "https://api.yelp.com/v3/businesses/search?term=\(searchTerm)&location=\(searchLocation)&sort_by=best_match&limit=10")
    }

    func testSingleBusinessEndpointIsConstructedCorrectly() throws {
        let testID = "test_id"
        let endpoint: Endpoint = .business(id: testID)
        XCTAssertEqual(endpoint.url.absoluteString,
                       "https://api.yelp.com/v3/businesses/\(testID)")
    }

    func testBusinessReviewsEndpointIsConstructedCorrectly() throws {
        let testID = "test_id"
        let endpoint: Endpoint = .reviews(business: testID, limit: 10)
        XCTAssertEqual(endpoint.url.absoluteString,
                       "https://api.yelp.com/v3/businesses/\(testID)/reviews?sort_by=yelp_sort&limit=10")
    }
}
