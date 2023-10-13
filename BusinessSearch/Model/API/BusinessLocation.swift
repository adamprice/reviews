import Foundation

struct BusinessLocation: Decodable {

    enum CodingKeys: String, CodingKey {
        case displayAddress = "display_address"
        case city = "city"
        case state = "state"
    }

    let city: String
    let state: String
    let displayAddress: [String]
}
