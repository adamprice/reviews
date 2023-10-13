import XCTest

@testable import BusinessSearch

@MainActor
final class BusinessDetailsViewModelTests: XCTestCase {

    var business: Business!
    var urlRequestClientMock: URLRequestClientMock!
    var openURLHandlerMock: OpenURLHandlerMock!
    var dateProviderMock: DateProviderMock!

    override func setUpWithError() throws {
        self.business = Business(id: "awesome_place_id",
                                 name: "Awesome Place",
                                 imageURL: URL(string: "https://my.awesome.place/image.jpg")!,
                                 rating: 5.0,
                                 location: BusinessLocation(city: "Toronto", state: "ON", displayAddress: ["123 Front Street"]),
                                 coordinates: BusinessCoordinates(latitude: 43.67428196976998, longitude: -79.39682006835938),
                                 categories: [BusinessCategory(alias: "bars", title: "Bars")],
                                 phone: "+14167007000",
                                 displayPhone: "+1 (416) 700-7000",
                                 url: URL(string: "https://my.awesome.place/")!,
                                 price: "$$$$",
                                 reviewCount: 416)

        self.urlRequestClientMock = URLRequestClientMock()
        self.openURLHandlerMock = OpenURLHandlerMock()
        self.dateProviderMock = DateProviderMock()
    }

    override func tearDownWithError() throws {
        self.business = nil
        self.urlRequestClientMock = nil
        self.openURLHandlerMock = nil
    }

    func testBusinessInfo() throws {
        // SUT
        let viewModel = BusinessDetailsViewModel(business: self.business,
                                                 client: self.urlRequestClientMock,
                                                 openURLHandler: self.openURLHandlerMock)

        XCTAssertEqual(viewModel.name, "Awesome Place")
        XCTAssertEqual(viewModel.price, "$$$$")
    }

    func testOpenURLHandling() throws {
        // SUT
        let viewModel = BusinessDetailsViewModel(business: self.business,
                                                 client: self.urlRequestClientMock,
                                                 openURLHandler: self.openURLHandlerMock)

        viewModel.viewOnYelp()

        XCTAssertEqual(openURLHandlerMock.lastOpenedURL!.absoluteString, "https://my.awesome.place/")
    }

    func testLoadAdditionalData() async throws {
        let response = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                       statusCode: 200,
                                       httpVersion: "1.1",
                                       headerFields: ["Content-Type": "application/json"])!
        self.urlRequestClientMock.requestReturnValue = (BusinessDetailsViewModelTests.additionalBusinessJSONData, response)

        self.dateProviderMock.dayOfWeekStartingAtZero = 0

        // SUT
        let viewModel = BusinessDetailsViewModel(business: self.business,
                                                 client: self.urlRequestClientMock,
                                                 openURLHandler: self.openURLHandlerMock)

        try await viewModel.loadBusiness(id: self.business.id)

        XCTAssertEqual(self.urlRequestClientMock.lastRequestedEndpoint!, .business(id: self.business.id))

        XCTAssertEqual(viewModel.imageURLs.map { $0.absoluteString },
                       ["https://s3-media1.fl.yelpcdn.com/bphoto/eleLP29pepclL6SRHMAyzA/o.jpg",
                        "https://s3-media1.fl.yelpcdn.com/bphoto/G8qlc0KpLX96GaDW4jkSPA/o.jpg",
                        "https://s3-media1.fl.yelpcdn.com/bphoto/m7h09NqiiMdNESy48R8YsA/o.jpg"])

        XCTAssertEqual(viewModel.openNow, true)
    }

    func testLoadReviewsData() async throws {
        let response = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                       statusCode: 200,
                                       httpVersion: "1.1",
                                       headerFields: ["Content-Type": "application/json"])!
        self.urlRequestClientMock.requestReturnValue = (BusinessDetailsViewModelTests.reviewsJSONData, response)

        // SUT
        let viewModel = BusinessDetailsViewModel(business: self.business,
                                                 client: self.urlRequestClientMock,
                                                 openURLHandler: self.openURLHandlerMock)

        try await viewModel.loadReviews(id: self.business.id)

        XCTAssertEqual(self.urlRequestClientMock.lastRequestedEndpoint!, .reviews(business: self.business.id))

        XCTAssertEqual(viewModel.reviewViewModels.first!.id, "Gylq7ADLHh595tz2pyW4CA")
        XCTAssertEqual(viewModel.reviewViewModels.first!.reviewRating, 5)
    }

    func testLoadReviewsDataDecodeFailure() async throws {
        let response = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                       statusCode: 200,
                                       httpVersion: "1.1",
                                       headerFields: ["Content-Type": "application/json"])!
        self.urlRequestClientMock.requestReturnValue = ("blah".data(using: .utf8)!, response)

        // SUT
        let viewModel = BusinessDetailsViewModel(business: self.business,
                                                 client: self.urlRequestClientMock,
                                                 openURLHandler: self.openURLHandlerMock)

        var testError: Error?

        do {
            try await viewModel.loadReviews(id: self.business.id)
        } catch {
            testError = error
        }

        guard case .failedToDecodeReviews = testError as? BusinessDetailsViewModel.Errors else {
            XCTFail()
            return
        }
    }

    private static let additionalBusinessJSONData = """
    {
        "id": "O_UC_izJXcAmkm6HlEyGSA",
        "photos": [
            "https://s3-media1.fl.yelpcdn.com/bphoto/eleLP29pepclL6SRHMAyzA/o.jpg",
            "https://s3-media1.fl.yelpcdn.com/bphoto/G8qlc0KpLX96GaDW4jkSPA/o.jpg",
            "https://s3-media1.fl.yelpcdn.com/bphoto/m7h09NqiiMdNESy48R8YsA/o.jpg"
        ],
        "hours": [
            {
                "open": [
                    {
                        "is_overnight": false,
                        "start": "1200",
                        "end": "2200",
                        "day": 0
                    }
                ],
                "hours_type": "REGULAR",
                "is_open_now": true
            }
        ]
    }
    """.data(using: .utf8)!

    private static let reviewsJSONData = """
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
