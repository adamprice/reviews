import SwiftUI

struct ActionButton: View {

    let image: Image
    let text: String
    let action: () -> ()

    init(image: Image, text: String, action: @escaping () -> ()) {
        self.image = image
        self.text = text
        self.action = action
    }

    var body: some View {
        Button(action: action,
               label: {
            Text("\(image)\n\(text)")
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .foregroundColor(.primary)
        })
        .buttonStyle(
            ActionButtonStyle()
        )
    }
}

#Preview {
    ActionButton(image: Image(systemName: "phone.fill"),
                 text: "Call",
                 action: {})
}
