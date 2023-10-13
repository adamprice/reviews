import Foundation
import CoreLocation

struct Business: Decodable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imageURL = "image_url"
        case rating = "rating"
        case location = "location"
        case coordinates = "coordinates"
        case categories = "categories"
        case phone = "phone"
        case displayPhone = "display_phone"
        case url = "url"
        case price = "price"
        case reviewCount = "review_count"
    }

    let id: String
    let name: String
    let imageURL: URL
    let rating: Double
    let location: BusinessLocation
    let coordinates: BusinessCoordinates
    let categories: [BusinessCategory]
    let phone: String
    let displayPhone: String
    let url: URL
    let price: String?
    let reviewCount: Int
}

struct BusinessCoordinates: Decodable {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees

    var coreLocationCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }

    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        self.longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
    }
}

extension Business: Identifiable {}
