import Foundation

struct BusinessCategory: Decodable {
    let alias: String
    let title: String
}

extension BusinessCategory: Identifiable {
    var id: String {
        alias
    }
}
