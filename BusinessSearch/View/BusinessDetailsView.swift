import SwiftUI

struct BusinessDetailsView: View {

    private enum Constants {
        static let topDividerTopPadding: CGFloat = 4
        static let bottomDividerTopPadding: CGFloat = -4
        static let ratingHStackSpacing: CGFloat = 6
        static let starRatingViewHeight: CGFloat = 15
        static let actionButtonsTopPadding: CGFloat = 2
        static let ratingVStackSpacing: CGFloat = 2
        static let openTextMinWidth: CGFloat = 128
    }

    @Bindable private var viewModel: BusinessDetailsViewModel

    init(viewModel: BusinessDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.top, .leading])
                    .accessibilityIdentifier("businessNameTitle")

                Text("\(viewModel.city), \(viewModel.state)")
                    .font(.subheadline)
                    .padding(.leading)
                    .foregroundStyle(.gray)

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.categoryViewModels) { categoryViewModel in
                            CategoryLabelView(viewModel: categoryViewModel)
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.never)
                .scrollBounceBehavior(.basedOnSize, axes: .horizontal)

                Divider()
                    .padding(.horizontal)
                    .padding(.top, Constants.topDividerTopPadding)

                HStack {
                    VStack(alignment: .leading) {
                        Text("BusinessDetalilsViewStatusLabel")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        Text(openText)
                            .frame(minWidth: Constants.openTextMinWidth,
                                   alignment: .leading)
                    }
                    Spacer()
                    Divider()
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("BusinessDetalilsViewPriceLabel")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        Text(priceText)
                    }
                    Spacer()
                    Divider()
                    Spacer()
                    VStack(alignment: .leading, spacing: Constants.ratingVStackSpacing) {
                        Text("BusinessDetalilsViewRatingLabel")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        HStack(alignment: .center, spacing: Constants.ratingHStackSpacing) {
                            StarRatingView(rating: viewModel.rating)
                                .frame(height: Constants.starRatingViewHeight)
                            Text(String(viewModel.rating))
                                .font(.subheadline)
                                .fontWeight(.bold)
                            + Text(" (\(viewModel.reviewCount))")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .padding(.horizontal)

                Divider()
                    .padding(.horizontal)
                    .padding(.top, Constants.bottomDividerTopPadding)

                HStack {
                    ActionButton(image: Image(systemName: "phone.fill"),
                                 text: "Call") {
                        viewModel.callBusiness()
                    }
                    ActionButton(image: Image(systemName: "safari.fill"),
                                 text: "View on Yelp") {
                        viewModel.viewOnYelp()
                    }
                }
                .padding(.horizontal)
                .padding(.top, Constants.actionButtonsTopPadding)

                Text("BusinessDetalilsViewPhotosLabel")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding([.top, .leading])

                BusinessImageCarouselView(imageURLs: viewModel.imageURLs)

                Text("BusinessDetalilsViewReviewsLabel")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding([.top, .leading])

                ReviewCarouselView(viewModels: viewModel.reviewViewModels)

                Text("BusinessDetalilsViewLocationLabel")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding([.top, .leading])

                LocationView(name: viewModel.name,
                             address: viewModel.address,
                             coordinate: viewModel.coordinates)
                    .padding(.horizontal)
            }
        }
        .safeAreaPadding(.bottom)
        .scrollIndicators(.never)
        .navigationTitle("BusinessDetailsViewNavigationTitle")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            self.loadAdditionalData()
        }
    }

    private func loadAdditionalData() {
        Task {
            try await viewModel.loadAdditionalBusinessData(id: viewModel.businessID)
        }
    }

    @MainActor private var openText: AttributedString {
        if let openNow = viewModel.openNow {
            var attributed = AttributedString(openNow ? "Open" : "Closed")
            attributed.foregroundColor = openNow ? .green : .red
            attributed.font = .subheadline.bold()

            if openNow, let openUntil = viewModel.openUntil {
                var openUntilString = AttributedString(" (until \(openUntil))")
                openUntilString.font = .subheadline
                openUntilString.foregroundColor = .gray
                attributed += openUntilString
            }

            return attributed
        }

        return AttributedString("-")
    }

    @MainActor private var priceText: AttributedString {
        if let price = viewModel.price {
            var attributed = AttributedString(price)
            attributed.font = .subheadline.bold()

            var extra = AttributedString(String(repeating: "$", count: 4 - price.count))
            extra.font = .subheadline.bold()
            extra.foregroundColor = .gray
            return attributed + extra
        }

        var unknown = AttributedString("Unknown")
        unknown.font = .subheadline
        return unknown
    }
}

#Preview {
    let viewModel = BusinessDetailsViewModel(business: BusinessesStubData.businesses.first!)
    return BusinessDetailsView(viewModel: viewModel)
}
