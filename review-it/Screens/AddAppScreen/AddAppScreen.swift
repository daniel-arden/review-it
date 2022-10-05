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
    func resultsView(appModels: [AppModel]) -> some View {
        if !appModels.isEmpty {
            ScrollView {
                LazyVStack {
                    ForEach(appModels) { appModel in
                        AppTileView(
                            appTileModel: .app(appModel),
                            action: {

                            }
                        )
                    }
                }
            }
        } else {
            informationText("No results found for given query. Try a different query.")
        }
    }

    var innerContentView: some View {
        ZStack {
            switch addAppScreenVM.searchState {
            case let .error(error):
                informationText(error.localizedDescription)
            case .initial:
                informationText("Search for apps on the AppStore")
            case let .results(appModels):
                resultsView(appModels: appModels)
            }
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
                .onSubmit(of: .search) {
                    addAppScreenVM.search()
                }
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
#endif

#if os(macOS)
// MARK: - MacOS Views
private extension AddAppScreen {
    var content: some View {
        VStack(spacing: 0) {
            SearchbarView(text: $addAppScreenVM.searchText)

            innerContentView

            Spacer()
        }
        .padding()
        .frame(
            maxWidth: 800
        )
        .onKeyDown(.escape) { dismiss() }
    }
}
#endif

struct AddAppScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddAppScreen()
    }
}
