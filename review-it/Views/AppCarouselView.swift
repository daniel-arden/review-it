import SwiftUI

struct AppCarouselView: View {
    @State private var addAppPresented = false
    @Binding var selection: AppModel?
    let tileModels: [AppTileModel]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(tileModels) { tileModel in
                    AppTileView(appTileModel: tileModel) {
                        handleAppTileViewTap(tileModel)
                    }
                }
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $addAppPresented) {
            Text("Add App Screen")
                .frame(minWidth: 200, minHeight: 200)
        }
    }
}

private extension AppCarouselView {
    func handleAppTileViewTap(_ tileModel: AppTileModel) {
        switch tileModel {
        case .addNew:
            addAppPresented.toggle()
        case let .app(appModel):
            selection = appModel
        }
    }
}
