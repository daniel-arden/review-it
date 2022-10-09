import SwiftUI

struct AppSearchResultView: View {
    let appSearchResult: AppSearchResult
    let addAction: () -> Void

    var body: some View {
        VStack {
            HStack {
                AppView(appSearchResult: appSearchResult)

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
