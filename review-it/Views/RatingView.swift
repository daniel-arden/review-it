import SwiftUI

struct RatingView: View {
    private static let starSpacing: CGFloat = 2
    private static let maxStarCount = 5
    let rating: Float

    var body: some View {
        HStack(spacing: Self.starSpacing) {
            ForEach(0..<Self.maxStarCount, id: \.self) { _ in
                Image(systemName: "star")
                    .foregroundColor(.secondary)
            }
        }
        .overlay {
            GeometryReader { proxy in
                HStack(spacing: Self.starSpacing) {
                    ForEach(0..<Self.maxStarCount, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                .mask {
                    HStack {
                        Rectangle()
                            .frame(
                                width: proxy.size.width * CGFloat(rating) / CGFloat(Self.maxStarCount)
                            )

                        Spacer(minLength: 0)
                    }
                }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RatingView(rating: 1)
            RatingView(rating: 2.3)
            RatingView(rating: 3)
            RatingView(rating: 3.8)
            RatingView(rating: 5.5)
        }
    }
}
