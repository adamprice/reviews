import Foundation

struct Review: Decodable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case text = "text"
        case rating = "rating"
        case created = "time_created"
        case user = "user"
    }

    let id: String
    let url: URL
    let text: String
    let rating: Int
    let created: String
    let user: User
}

extension Review: Identifiable {}
