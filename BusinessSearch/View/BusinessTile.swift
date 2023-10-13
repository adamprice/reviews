import SwiftUI

struct BusinessTile: View {

    private enum Constants {
        static let viewHeight: CGFloat = 150
        static let starRatingViewHeight: CGFloat = 15
        static let infoStackSpacing: CGFloat = 5
        static let labelLineLimit = 1
        static let tileGradient = Gradient(
            colors: [
                .clear, .clear, .black.opacity(0.6), .black.opacity(0.8)
            ])
    }

    private let viewModel: BusinessViewModel

    init(viewModel: BusinessViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: viewModel.imageURL) { phase in
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
            .frame(height: Constants.viewHeight)
            .frame(minWidth: .zero, maxWidth: .infinity)

            Rectangle()
                .fill(LinearGradient(
                    gradient: Constants.tileGradient,
                    startPoint: .top,
                    endPoint: .bottom))
                .frame(height: Constants.viewHeight)
                .frame(minWidth: .zero, maxWidth: .infinity)

            VStack(alignment: .leading, spacing: Constants.infoStackSpacing) {
                Text(viewModel.name)
                    .font(.headline)
                    .lineLimit(Constants.labelLineLimit)
                HStack(alignment: .center) {
                    StarRatingView(rating: viewModel.rating)
                        .frame(height: Constants.starRatingViewHeight)
                    Text(String(viewModel.rating))
                        .font(.subheadline)
                }

            }
            .foregroundColor(.white)
            .padding()
        }
        .background(.gray)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
    }
}

#Preview {
    let viewModel = BusinessViewModel(business: BusinessesStubData.businesses.first!)
    return BusinessTile(viewModel: viewModel)
        .frame(width: 150)
}
