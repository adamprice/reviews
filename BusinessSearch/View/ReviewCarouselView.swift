import SwiftUI

struct ReviewCarouselView: View {

    private enum Constants {
        static let width: CGFloat = 300
    }

    private let viewModels: [ReviewViewModel]

    init(viewModels: [ReviewViewModel]) {
        self.viewModels = viewModels
    }

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModels) { viewModel in
                    SingleReviewView(viewModel: viewModel)
                        .frame(width: Constants.width)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    let review = Review(id: "review_id",
                        url: URL(string: "https://review.url")!,
                        text: "Review Text",
                        rating: 5,
                        created: "2023-05-07 11:29:31",
                        user: User(id: "user_id",
                                   profileURL: URL(string: "https://profile.url")!,
                                   imageURL: nil,
                                   name: "Adam P."))

    let reviewViewModel = ReviewViewModel(review: review)
    return ReviewCarouselView(viewModels: [reviewViewModel, reviewViewModel])
}
