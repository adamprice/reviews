import Foundation

struct User: Decodable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case profileURL = "profile_url"
        case imageURL = "image_url"
        case name = "name"
    }

    let id: String
    let profileURL: URL
    let imageURL: URL?
    let name: String
}

extension User: Identifiable {}
