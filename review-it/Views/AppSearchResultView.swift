import SwiftUI

struct AppSearchResultView: View {
    let appSearchResult: AppSearchResult
    let addAction: () -> Void

    var body: some View {
        VStack {
            HStack {
                HStack {
                    AsyncImage(url: appSearchResult.artworkUrl100)
                        .frame(width: 80, height: 80)
                        .cornerRadius(12)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(appSearchResult.sellerName)
                            .font(.headline)

                        Link(
                            appSearchResult.sellerName,
                            destination: appSearchResult.artistViewUrl
                        )
                    }
                }

                Spacer()

                Button("ADD", action: addAction)
                    .buttonStyle(RoundedButtonStyle())
            }
        }
        .padding()
        .background(Color.backgroundSecondary)
        .cornerRadius(12)
    }
}

struct AppSearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        AppSearchResultView(
            appSearchResult: AppSearchResult(
                trackName: "Soccer Stars: Football Kick",
                artworkUrl100: URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Purple112/v4/d4/e0/a1/d4e0a1e7-50da-e05a-0074-429e0ee61777/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/100x100bb.jpg")!,
                artistViewUrl: URL(string: "https://apps.apple.com/us/developer/miniclip-com/id337457683?uo=4")!,
                sellerName: "Miniclip SA",
                userRatingCount: 40
            ),
            addAction: {}
        )
    }
}
