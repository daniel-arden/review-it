import SwiftUI

struct ReviewListScreen: View {
    @StateObject private var viewModel = ReviewListVM()
    @ObservedObject private var userSettings = UserSettingsService.shared

    @State private var isEditing = false
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

    var body: some View  { content }
}

private extension ReviewListScreen {
    var innerContentView: some View {
        VStack(spacing: 0) {
            LazyVStack(spacing: 0) {
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
                                AppTileView(
                                    appTileModel: tileModel,
                                    isSelected: viewModel.selectedAppId == tileModel.id,
                                    isEditing: isEditing
                                ) {
                                    viewModel.selectedAppId = tileModel.id
                                } onDelete: {
                                    if case let .app(appModel) = tileModel {
                                        viewModel.removeApp(appModel)
                                    }

                                    if appModels.isEmpty {
                                        isEditing = false
                                    }
                                }
                            }

                            AppTileView(appTileModel: .addNew, isSelected: false, isEditing: false) {
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
            .toolbar {
                ToolbarItem {
                    HStack(spacing: 0) {
                        Button {
                            addAppPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .frame(width: 40, height: 40)

                        #if !os(macOS)
                        NavigationLink {
                            SettingsScreen()
                        } label: {
                            Image(systemName: "gear")
                        }
                        .frame(width: 40, height: 40)
                        #endif

                        editButton
                    }
                }
            }

            if userSettings.reviewListControls {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        CountryFilterPicker()
//                        SeenStatusFilterPicker() // TODO: Logic not implemented
                    }
                    .padding()
                }
            }

            Divider()

            ScrollView {
                switch viewModel.viewState {
                case let .error(error):
                    InformationText(error.localizedDescription)
                case .initial:
                    InformationText("Please add apps that you want to observe")
                case .loading:
                    LoadingView()
                case let .results(reviews):
                    if reviews.isEmpty {
                        InformationText("No reviews available for given filters")
                    } else {
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

                                ForEach(reviews) {
                                    ReviewCardView(review: $0)
                                }
                            }
                            .padding()
                        }
                        .refreshable { viewModel.fetchReviews() }
                    }
                }
            }
        }
        .frame(minWidth: 400, minHeight: 400)
        .sheet(isPresented: $addAppPresented) {
            AddAppScreen {
                viewModel.selectLast()
                shouldScrollAppListToFirst = UUID()
            }
        }
    }
}

private extension ReviewListScreen {
    @ViewBuilder
    var editButton: some View {
        if !appModels.isEmpty {
            Button(isEditing ? "Done" : "Edit") {
                isEditing.toggle()
            }
        }
    }
}

#if os(iOS)
// MARK: - iOS Views
private extension ReviewListScreen {
    var content: some View {
        NavigationStack {
            innerContentView
        }
    }
}
#elseif os(macOS)
// MARK: - MacOS Views
private extension ReviewListScreen {
    var content: some View { innerContentView }
}
#endif

struct ReviewListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListScreen()
    }
}
