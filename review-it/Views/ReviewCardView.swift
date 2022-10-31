import SwiftUI

struct ReviewCardView: View {
    let review: Review

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading) {
                    Text(review.title)
                    if let rating = review.rating {
                        RatingView(rating: rating)
                            .padding(.top, 1)
                    }
                }
                .font(.headline)

                Spacer()

                VStack(alignment: .trailing) {
                    if let dateFormatted = review.dateUpdated?.formatted(
                        date: .numeric,
                        time: .shortened
                    ) {
                        Text(dateFormatted)
                    }

                    Text(review.authorName)
                }
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
            }

            Text(review.caption)
        }
        .padding()
        .background(Color.backgroundSecondary)
        .cornerRadius(12)
        .textSelection(.enabled)
    }
}
