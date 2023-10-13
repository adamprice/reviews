import SwiftUI

@MainActor
final class CategoryLabelViewModel {
    private let businessCategory: BusinessCategory

    var label: String {
        businessCategory.title
    }

    var emoji: String {
        switch businessCategory.alias {
        case "mexican":
            return "🌮"
        case "bars", "pubs":
            return "🍺"
        case "japanese":
            return "🇯🇵"
        case "seafood":
            return "🦀"
        case "sushi_bars":
            return "🍣"
        case "chicken_wings":
            return "🍗"
        case "hotdogs":
            return "🍟"
        default:
            return "🍴"
        }
    }

    init(businessCategory: BusinessCategory) {
        self.businessCategory = businessCategory
    }
}

extension CategoryLabelViewModel: Identifiable {
    var id: String {
        businessCategory.alias
    }
}
