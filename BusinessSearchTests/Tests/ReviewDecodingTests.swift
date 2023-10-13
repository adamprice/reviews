import XCTest

@testable import BusinessSearch

final class ReviewDecodingTests: XCTestCase {

    func testDecoding() throws {
        let decoder = JSONDecoder()

        let review = try decoder.decode(ReviewsResponse.self, from: ReviewDecodingTests.json).reviews.first!

        XCTAssertEqual(review.id, "Gylq7ADLHh595tz2pyW4CA")
        XCTAssertEqual(review.url.absoluteString, "https://test.com/reviews")
        XCTAssertEqual(review.text, "review_text")
        XCTAssertEqual(review.rating, 5)
    }

    private static let json = """
    {
        "reviews": [
            {
                "id": "Gylq7ADLHh595tz2pyW4CA",
                "url": "https://test.com/reviews",
                "text": "review_text",
                "rating": 5,
                "time_created": "2023-05-07 11:29:31",
                "user": {
                    "id": "oPzFN6yGnhQL051ws3a17A",
                    "profile_url": "https://www.yelp.com/user_details?userid=oPzFN6yGnhQL051ws3a17A",
                    "image_url": "https://s3-media3.fl.yelpcdn.com/photo/SCC5zDBmAbeH2gdkYIEHNQ/o.jpg",
                    "name": "Reh L."
                }
            }
        ],
        "total": 475,
        "possible_languages": [
            "en"
        ]
    }
    """.data(using: .utf8)!
}
