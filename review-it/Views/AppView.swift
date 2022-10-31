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
            .frame(width: dimension, height: dimension)
            .cornerRadius(12)

            VStack(alignment: .leading, spacing: 4) {
                Text(appName)
                    .font(.headline)

                Link(developerName, destination: developerUrl)

                Spacer()
                    .frame(height: 2)

                RatingView(rating: rating, labelVisible: true)
            }
            .multilineTextAlignment(.leading)
            .padding(.vertical)
        }
    }
}
