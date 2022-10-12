import SwiftUI

struct ReviewListScreen: View {
    @StateObject private var viewModel = ReviewListVM()
    @State private var addAppPresented = false

    @State private var shouldScrollAppListToFirst = UUID()
    @State private var shouldScrollReviewListToTop = UUID()

    /// Used for hacking a way how to scroll to top in a vertical `ScrollView`
    private static let reviewListTopViewId = "reviewListTopViewId"
    /// Used for hacking a way how to scroll to the leading view  in a horizontal `ScrollView`
    private static let appListFirstViewId = "appListFirstViewId"

    @FetchRequest(
        sortDescriptors: AppModel.sortDescriptors()
    )
    private var appModels: FetchedResults<AppModel>

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        HStack {
                            // FIXME: Scrolling to the first position on iOS
                            Spacer()
                                .frame(width: 1)
                                .id(Self.appListFirstViewId)
                                .onChange(of: shouldScrollAppListToFirst) { _ in
                                    withAnimation {
                                        proxy.scrollTo(Self.appListFirstViewId)
                                    }
                                }

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
                }
                .padding(.vertical)

                Divider()
            }
            .fixedSize(horizontal: false, vertical: true)

            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack(alignment: .leading) {
                        Spacer()
                            .frame(height: 1)
                            .id(Self.reviewListTopViewId)
                            .onChange(of: shouldScrollReviewListToTop) { _ in
                                proxy.scrollTo(Self.reviewListTopViewId)
                            }
                            .onChange(of: viewModel.selectedAppId) { _ in
                                shouldScrollReviewListToTop = UUID()
                            }

                        ForEach(viewModel.reviews) {
                            ReviewCardView(review: $0)
                        }
                    }
                    .padding()
                }
            }
            .overlay {
                if viewModel.reviews.isEmpty {
                    Text("Please add apps that you want to observe")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(.secondary)
                }
            }
            .refreshable { viewModel.fetchReviews() }
        }
        .frame(minWidth: 400, minHeight: 400)
        .onAppear(perform: viewModel.fetchReviews)
        .sheet(isPresented: $addAppPresented) {
            AddAppScreen {
                viewModel.selectLast()
                shouldScrollAppListToFirst = UUID()
            }
        }
    }
}

struct ReviewListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListScreen()
    }
}
