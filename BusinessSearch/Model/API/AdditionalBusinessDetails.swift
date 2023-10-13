import Foundation

struct AdditionalBusinessDetails: Decodable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case photos = "photos"
        case hours = "hours"
    }

    let id: String
    let photos: [URL]
    let hours: [Hours]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.photos = try container.decode([URL].self, forKey: .photos)
        self.hours = try container.decodeIfPresent([Hours].self, forKey: .hours) ?? []
    }
}

struct Hours: Decodable {

    enum CodingKeys: String, CodingKey {
        case hoursType = "hours_type"
        case openNow = "is_open_now"
        case days = "open"
    }

    let days: [SingleDayHours]
    let hoursType: String
    let openNow: Bool
}

extension Hours: Equatable {}

struct SingleDayHours: Decodable {

    enum CodingKeys: String, CodingKey {
        case day = "day"
        case start = "start"
        case end = "end"
        case isOvernight = "is_overnight"
    }

    let day: Int
    let start: String
    let end: String
    let isOvernight: Bool
}

extension SingleDayHours: Equatable {}

extension AdditionalBusinessDetails: Identifiable {}
