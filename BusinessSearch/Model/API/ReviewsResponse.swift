import Foundation

struct ReviewsResponse: Decodable {

    enum CodingKeys: String, CodingKey {
        case reviews = "reviews"
        case total = "total"
        case possibleLanguages = "possible_languages"
    }

    let reviews: [Review]
    let total: Int
    let possibleLanguages: [String]
}
