import SwiftUI

struct RatingView: View {
    let rating: Rating

    private var filledStarsCount: Int { rating.rawValue }
    private var nonFilledStarsCount: Int { 5 - rating.rawValue }

    var body: some View {
        HStack {
            ForEach(0..<filledStarsCount, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }

            ForEach(0..<nonFilledStarsCount, id: \.self) { _ in
                Image(systemName: "star")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RatingView(rating: .one)
            RatingView(rating: .two)
            RatingView(rating: .three)
            RatingView(rating: .four)
            RatingView(rating: .five)
        }
    }
}
