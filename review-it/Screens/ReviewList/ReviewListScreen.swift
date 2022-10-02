import SwiftUI

struct ReviewListScreen: View {
    @StateObject private var viewModel = ReviewListVM()

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.reviews) {
                    ReviewCardView(review: $0)
                }
            }
            .padding()
        }
        .frame(minWidth: 400, minHeight: 400)
        .task {
            do {
                try await viewModel.fetchReviews()
            } catch {
                print("Something went wrong: \(error)")
            }
            print("Started fetching reviews")
        }
    }
}

struct ReviewListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListScreen()
    }
}
