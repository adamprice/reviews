#if DEBUG
import Foundation

class StubURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        let response = HTTPURLResponse(url: request.url!, 
                                       statusCode: 200,
                                       httpVersion: "1.1",
                                       headerFields: ["Content-Type": "application/json"])!
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: StubHandler.shared.stub(for: request.url!))
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}

class StubHandler {

    static let shared = StubHandler()

    private var stubResponses: [String: Data] = [:]

    init() {
        stubResponses["/v3/businesses/search"] = BusinessesStubData.businessesJSON.data(using: String.Encoding.utf8)!
        stubResponses["/v3/businesses/O_UC_izJXcAmkm6HlEyGSA"] = BusinessesStubData.singleBusinessJSON.data(using: String.Encoding.utf8)!
        stubResponses["/v3/businesses/O_UC_izJXcAmkm6HlEyGSA/reviews"] = ReviewStubData.reviewsJSON.data(using: String.Encoding.utf8)!
        stubResponses["/bphoto/eleLP29pepclL6SRHMAyzA/o.jpg"] = Data(base64Encoded: BusinessesStubData.image)
        stubResponses["/bphoto/G8qlc0KpLX96GaDW4jkSPA/o.jpg"] = Data(base64Encoded: BusinessesStubData.image)
        stubResponses["/bphoto/m7h09NqiiMdNESy48R8YsA/o.jpg"] = Data(base64Encoded: BusinessesStubData.image)
    }

    func stub(for url: URL) -> Data {
        return stubResponses[url.path(percentEncoded: false)] ?? Data()
    }
}
#endif
