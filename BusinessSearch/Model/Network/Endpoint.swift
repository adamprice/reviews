import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.yelp.com"
        components.path = "/v3/" + path

        if queryItems.isEmpty == false {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }

        return url
    }
}

extension Endpoint {
    static func search(for query: String, location: String = "Toronto",  limit: Int = 10) -> Self {
        Endpoint(
            path: "businesses/search",
            queryItems: [
                URLQueryItem(
                    name: "term",
                    value: query
                ),
                URLQueryItem(
                    name: "location",
                    value: location
                ),
                URLQueryItem(
                    name: "sort_by",
                    value: "best_match"
                ),
                URLQueryItem(
                    name: "limit",
                    value: String(limit)
                )
            ]
        )
    }

    static func business(id: String) -> Self {
        Endpoint(
            path: "businesses/\(id)",
            queryItems: []
        )
    }

    static func reviews(business id: String, limit: Int = 10) -> Self {
        Endpoint(
            path: "businesses/\(id)/reviews",
            queryItems: [
                URLQueryItem(
                    name: "sort_by",
                    value: "yelp_sort"
                ),
                URLQueryItem(
                    name: "limit",
                    value: String(limit)
                )
            ]
        )
    }
}

extension Endpoint: Equatable {}
