import SwiftUI

struct CategoryLabelView: View {

    private enum Constants {
        static let cornerSize = CGSize(width: 5, height: 5)
        static let labelPadding: CGFloat = 5
    }

    private let viewModel: CategoryLabelViewModel

    init(viewModel: CategoryLabelViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: Constants.cornerSize)
                .foregroundStyle(Color.secondarySystemBackground)
            Text("\(viewModel.emoji) \(viewModel.label)")
                .background(.clear)
                .font(.subheadline)
                .padding(Constants.labelPadding)
        }
        .frame(minWidth: .zero, maxWidth: .infinity)
        .fixedSize()
    }
}

#Preview {
    let viewModel = CategoryLabelViewModel(businessCategory: BusinessCategory(alias: "mexican", title: "Mexican"))
    return CategoryLabelView(viewModel: viewModel)
}
