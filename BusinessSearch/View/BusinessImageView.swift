import SwiftUI

struct BusinessImageView: View {

    private enum Constants {
        static let width: CGFloat = 200
        static let height: CGFloat = 250
    }

    private let imageURL: URL

    init(imageURL: URL) {
        self.imageURL = imageURL
    }

    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: Constants.width, height: Constants.height)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
    }
}
