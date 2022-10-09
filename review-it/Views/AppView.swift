import SwiftUI

struct AppView: View {
    private let appIconUrl: URL
    private let appName: String
    private let developerName: String
    private let developerUrl: URL
    private let id: Int
    private let rating: Float
    private let dimension: CGFloat

    init(appModel: AppModel) {
        self.appIconUrl = appModel.appIconUrl
        self.appName = appModel.appName
        self.developerName = appModel.developerName
        self.developerUrl = appModel.developerUrl
        self.id = appModel.id
        self.rating = appModel.rating
        self.dimension = 48
    }

    init(appSearchResult: AppSearchResult) {
        self.appIconUrl = appSearchResult.appIconUrl
        self.appName = appSearchResult.appName
        self.developerName = appSearchResult.developerName
        self.developerUrl = appSearchResult.developerUrl
        self.id = appSearchResult.id
        self.rating = appSearchResult.ratingRounded
        self.dimension = 80
    }

    var body: some View {
        HStack {
            AsyncImage(url: appIconUrl) { image in
                image
                    .resizable()
            } placeholder: {
                Color.backgroundTertiary
            }
            .frame(width: 80, height: 80)
            .cornerRadius(12)

            VStack(alignment: .leading, spacing: 4) {
                Text(appName)
                    .font(.headline)

                Link(developerName, destination: developerUrl)

                Spacer()

                RatingView(rating: rating)
            }
            .multilineTextAlignment(.leading)
            .padding(.vertical)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(
            appModel: AppModel(
                appIconUrl: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Purple115/v4/9c/b1/9b/9cb19bee-a4cd-8660-95a4-fa559f0c1b88/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/100x100bb.jpg")!,
                appName: "Soccer Stars: Football Kick",
                developerName: "Miniclip SA",
                developerUrl: URL(string: "https://www.miniclip.com")!,
                rating: 4.5,
                id: 33939
            )
        )
    }
}
