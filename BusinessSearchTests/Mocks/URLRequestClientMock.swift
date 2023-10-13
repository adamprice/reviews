import UIKit

@testable import BusinessSearch

class URLRequestClientMock: URLRequestClient {

    enum MockError: Error {
        case noMockedResponse
    }

    var lastRequestedEndpoint: Endpoint?
    var requestReturnValue: (Data, URLResponse)?

    func request(_ endpoint: Endpoint) async throws -> (Data, URLResponse) {
        self.lastRequestedEndpoint = endpoint
        guard let requestReturnValue else { throw MockError.noMockedResponse }
        return requestReturnValue
    }
}
