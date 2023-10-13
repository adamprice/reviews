import SwiftUI

struct ActionButtonStyle: ButtonStyle {

    private enum Constants {
        static let height: CGFloat = 60
        static let cornerRadius: CGFloat = 10
    }

    private let backgroundColor: Color

    init(backgroundColor: Color = Color.secondarySystemBackground) {
        self.backgroundColor = backgroundColor
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.bold())
            .frame(height: Constants.height)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(Constants.cornerRadius)
    }
}
