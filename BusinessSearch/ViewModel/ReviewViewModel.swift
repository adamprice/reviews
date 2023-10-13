import Foundation

@MainActor
final class ReviewViewModel {
    private let review: Review

    var profileImageURL: URL? {
        review.user.imageURL
    }

    var reviewText: String {
        review.text
    }

    var reviewUsername: String {
        review.user.name
    }

    var reviewRating: Int {
        review.rating
    }

    init(review: Review) {
        self.review = review
    }
}

extension ReviewViewModel: Identifiable {
    var id: String {
        review.id
    }
}
