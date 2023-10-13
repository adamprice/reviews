import SwiftUI

struct BusinessImageCarouselView: View {

    private let imageURLs: [URL]

    init(imageURLs: [URL]) {
        self.imageURLs = imageURLs
    }

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(imageURLs, id: \.self) { url in
                    BusinessImageView(imageURL: url)
                }
            }
            .padding(.horizontal)
        }
    }
}
