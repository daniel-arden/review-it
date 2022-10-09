import SwiftUI

struct AppSearchResultView: View {
    let appSearchResult: AppSearchResult
    let addAction: () -> Void

    var body: some View {
        VStack {
            HStack {
                HStack {
                    AsyncImage(url: appSearchResult.appIconUrl) { image in
                        image
                            .resizable()
                    } placeholder: {
                        Color.backgroundTertiary
                    }
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(appSearchResult.appName)
                            .font(.headline)

                        Link(
                            appSearchResult.developerName,
                            destination: appSearchResult.developerUrl
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
