import Foundation
import CoreLocation

struct BasicBusiness: Decodable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imageURL = "image_url"
        case rating = "rating"
        case location = "location"
    }

    let id: String
    let name: String
    let imageURL: URL
    let rating: Double
    let location: BusinessLocation
}

extension BasicBusiness: Identifiable {}
