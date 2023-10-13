import SwiftUI

struct StarRatingView: View {

    enum Constants {
        static let totalStars = 5
    }

    let rating: Double

    private var starFillValues: [Double]

    init(rating: Double) {
        self.rating = rating

        let fullStars: Int = Int(floor(rating))
        let partialStar = rating.truncatingRemainder(dividingBy: 1)

        starFillValues = [Double](repeating: 1.0, count: fullStars)

        if fullStars < Constants.totalStars && partialStar != 0 {
            starFillValues.append(partialStar)
        }
    }

    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            ForEach(0 ..< Constants.totalStars, id: \.self) { iteration in
                GeometryReader { star in
                    ZStack {
                        Image(systemName: "star")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.gray)

                        if iteration < starFillValues.count {
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.blue)
                                .mask(
                                    Rectangle()
                                        .size(
                                            width: star.size.width * starFillValues[iteration],
                                            height: star.size.height
                                        )
                                    )
                        }
                    }
                }
                .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#Preview {
    StarRatingView(rating: 3.5)
}
