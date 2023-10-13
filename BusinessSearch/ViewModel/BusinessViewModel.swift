import Foundation

@MainActor
final class BusinessViewModel {

    private let business: Business

    init(business: Business) {
        self.business = business
    }

    var businessID: String {
        business.id
    }

    var name: String {
        business.name
    }

    var rating: Double {
        business.rating
    }

    var imageURL: URL {
        business.imageURL
    }

    var id: String {
        business.id
    }

    var businessDetailsViewModel: BusinessDetailsViewModel {
        BusinessDetailsViewModel(business: business)
    }
}

extension BusinessViewModel: Identifiable {}
