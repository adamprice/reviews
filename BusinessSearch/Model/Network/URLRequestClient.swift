import Foundation

protocol URLRequestClient {
    func request(_ endpoint: Endpoint) async throws -> (Data, URLResponse)
}

extension URLSession: URLRequestClient {

    private enum Constants {
        static let apiKey = "9tycsrc6_ftCRHuZ_HM_e-6qDUfJlCulugTXYByqGacdZpsT48zQnQUvHJ7Pm25bCK7j7b4LOeZDprsAeDV1F2WYstGAovEt09hEE-Bf_nO5BsCcJPuESIuLvqAhZXYx"
    }

    func request(_ endpoint: Endpoint) async throws -> (Data, URLResponse) {
        var request = URLRequest(url: endpoint.url)

        request.setValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        return try await data(for: request)
    }
}
