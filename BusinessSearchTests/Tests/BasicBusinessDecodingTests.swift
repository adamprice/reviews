import XCTest

@testable import BusinessSearch

final class BasicBusinessDecodingTests: XCTestCase {

    func testDecoding() throws {
        let decoder = JSONDecoder()

        let business = try decoder.decode(BusinessesResponse.self, from: BasicBusinessDecodingTests.json).businesses.first!

        XCTAssertEqual(business.name, "Playa Cabana")
        XCTAssertEqual(business.imageURL.absoluteString, "https://s3-media1.fl.yelpcdn.com/bphoto/eleLP29pepclL6SRHMAyzA/o.jpg")
        XCTAssertEqual(business.rating, 4.0)
        XCTAssertEqual(business.phone, "+14169293911")
    }

    private static let json = """
    {
        "businesses": [
            {
                "id": "O_UC_izJXcAmkm6HlEyGSA",
                "alias": "playa-cabana-toronto",
                "name": "Playa Cabana",
                "image_url": "https://s3-media1.fl.yelpcdn.com/bphoto/eleLP29pepclL6SRHMAyzA/o.jpg",
                "is_closed": false,
                "url": "https://www.yelp.com/biz/playa-cabana-toronto?adjust_creative=PQVS3ONnOnj28MY1lNz-_g&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=PQVS3ONnOnj28MY1lNz-_g",
                "review_count": 475,
                "categories": [
                    {
                        "alias": "mexican",
                        "title": "Mexican"
                    },
                    {
                        "alias": "bars",
                        "title": "Bars"
                    }
                ],
                "rating": 4.0,
                "coordinates": {
                    "latitude": 43.6759577692695,
                    "longitude": -79.4011840224266
                },
                "transactions": [],
                "price": "$$",
                "location": {
                    "address1": "111 Dupont Street",
                    "address2": "",
                    "address3": "",
                    "city": "Toronto",
                    "zip_code": "M5R 1V4",
                    "country": "CA",
                    "state": "ON",
                    "display_address": [
                        "111 Dupont Street",
                        "Toronto, ON M5R 1V4",
                        "Canada"
                    ]
                },
                "phone": "+14169293911",
                "display_phone": "+1 416-929-3911",
                "distance": 397.3648796523013
            }
        ],
        "total": 471,
        "region": {
            "center": {
                "longitude": -79.39682006835938,
                "latitude": 43.67428196976998
            }
        }
    }
    """.data(using: .utf8)!
}
