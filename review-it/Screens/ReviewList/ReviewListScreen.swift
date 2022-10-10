import SwiftUI

struct ReviewListScreen: View {
    @StateObject private var viewModel = ReviewListVM()
    @State private var addAppPresented = false

    @FetchRequest(
        sortDescriptors: AppModel.sortDescriptors()
    )
    private var appModels: FetchedResults<AppModel>

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(appModels.map { AppTileModel.app($0) } ) { tileModel in
                            AppTileView(appTileModel: tileModel, isSelected: viewModel.selectedAppId == tileModel.id ) {
                                viewModel.selectedAppId = tileModel.id
                            }
                        }

                        AppTileView(appTileModel: .addNew, isSelected: false) {
                            addAppPresented.toggle()
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)

                Divider()
            }
            .fixedSize(horizontal: false, vertical: true)

            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.reviews) {
                        ReviewCardView(review: $0)
                    }
                }
                .padding()
            }
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
        .sheet(isPresented: $addAppPresented) {
            AddAppScreen()
        }
    }
}

struct ReviewListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListScreen()
    }
}
