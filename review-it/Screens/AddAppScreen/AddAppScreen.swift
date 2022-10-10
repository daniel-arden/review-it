import SwiftUI

struct AddAppScreen: View {
    @StateObject private var addAppScreenVM = AddAppScreenVM()
    @Environment(\.dismiss) private var dismiss

    var body: some View { content }
}

/*
 https://performance-partners.apple.com/resources/documentation/itunes-store-web-service-search-api.html
 https://stackoverflow.com/questions/5551617/apple-appstore-name-search-via-the-api
 */
private extension AddAppScreen {
    func informationText(_ text: String) -> some View {
        Text(text)
            .multilineTextAlignment(.center)
            .font(.callout)
            .foregroundColor(.secondary)
            .padding(.vertical)
    }

    @ViewBuilder
    func resultsView(appSearchResults: [AppSearchResult]) -> some View {
        if !appSearchResults.isEmpty {
            ScrollView {
                LazyVStack {
                    ForEach(appSearchResults) { appSearchResult in
                        AppSearchResultView(
                            appSearchResult: appSearchResult
                        ) {
                            addAppScreenVM.addApp(appSearchResult)
                            dismiss()
                        }
                    }
                }
            }
        } else {
            informationText("No results found for given query. Try a different query.")
        }
    }

    @ViewBuilder
    var innerContentView: some View {
        switch addAppScreenVM.searchState {
        case let .error(error):
            informationText(error.localizedDescription)
        case .searching:
            VStack {
                Spacer()

                ProgressView()
                    .progressViewStyle(.circular)

                Spacer()
            }
        case .initial:
            informationText("Search for apps on the AppStore")
        case let .results(appSearchResults):
            resultsView(appSearchResults: appSearchResults)
        }
    }
}

#if os(iOS)
// MARK: - iOS Views
private extension AddAppScreen {
    var content: some View {
        NavigationView {
            innerContentView
                .searchable(text: $addAppScreenVM.searchText)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "multiply")
                        }

                    }
                }
        }
    }
}
#elseif os(macOS)
// MARK: - MacOS Views
private extension AddAppScreen {
    var content: some View {
        VStack(spacing: 0) {
            SearchbarView(text: $addAppScreenVM.searchText)

            innerContentView

            Spacer()
        }
        .padding([.top, .horizontal])
        .onKeyDown(.escape) { dismiss() }
        .frame(
            minWidth: 400,
            idealWidth: 500,
            maxWidth: 700,
            minHeight: 400,
            idealHeight: 500,
            maxHeight: 1000
        )
    }
}
#endif

struct AddAppScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddAppScreen()
    }
}
