import SwiftUI

struct SingleReviewView: View {

    enum Constants {
        static let profileImageHeight: CGFloat = 30
        static let profileImageWidth: CGFloat = 30
        static let starRatingHeight: CGFloat = 10
    }

    private let viewModel: ReviewViewModel

    init(viewModel: ReviewViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.reviewText)
                    .lineLimit(4)
                    .font(.body)
                HStack {
                    if let profileImageURL = viewModel.profileImageURL {
                        UserProfileImageView(profileImageURL: profileImageURL)
                            .frame(width: Constants.profileImageWidth,
                                   height: Constants.profileImageHeight)
                    } else {
                        UserProfileImageMissingView()
                            .frame(width: Constants.profileImageWidth,
                                   height: Constants.profileImageHeight)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        StarRatingView(rating: Double(viewModel.reviewRating))
                            .frame(height: Constants.starRatingHeight)
                        Text(viewModel.reviewUsername)
                            .font(.caption)
                    }
                }
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(Color.secondarySystemBackground)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
    }
}

struct UserProfileImageView: View {

    private let profileImageURL: URL

    init(profileImageURL: URL) {
        self.profileImageURL = profileImageURL
    }

    var body: some View {
        AsyncImage(url: profileImageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            case .failure:
                UserProfileImageMissingView()
            @unknown default:
                EmptyView()
            }
        }
        .mask(Circle())
    }
}

struct UserProfileImageMissingView: View {
    var body: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .foregroundColor(.gray)
    }
}

extension Color {
    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
}

#Preview {
    let viewModel = ReviewViewModel(review: ReviewStubData.reviews.first!)

    return SingleReviewView(viewModel: viewModel)}
