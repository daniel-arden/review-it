import SwiftUI

struct AppTileView: View {
    private static let appIconDimension: CGFloat = 48
    let appTileModel: AppTileModel
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                switch appTileModel {
                case .addNew:
                    addNewContent()
                case let .app(appModel):
                    appContent(appModel: appModel)
                }
            }
            .padding()
            .background(Color.backgroundSecondary)
            .cornerRadius(12)
        }
        .buttonStyle(BouncingButtonStyle())
    }
}

private extension AppTileView {
    @ViewBuilder
    func addNewContent() -> some View {
        HStack {
            Image(systemName: "plus")
                .resizable()
                .frame(
                    width: Self.appIconDimension / 2,
                    height: Self.appIconDimension / 2
                )
                .frame(
                    width: Self.appIconDimension,
                    height: Self.appIconDimension
                )
                .background(Color.primary.opacity(0.1))
                .cornerRadius(8)

            Text("Add App")
                .font(.headline)
        }
    }

    @ViewBuilder
    func appContent(appModel: AppModel) -> some View {
        HStack {
            Image(image: appModel.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: Self.appIconDimension,
                    height: Self.appIconDimension
                )
                .background(Color.primary.opacity(0.1))
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(appModel.name)
                    .font(.headline)

                Text(appModel.developerName)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct AppTileView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.horizontal) {
            HStack {
                AppTileView(
                    appTileModel: .app(
                        .init(
                            name: "Simple Azbuka",
                            developerName: "Daniel Arden",
                            icon: .init()
                        )
                    ),
                    action: {}
                )
                AppTileView(
                    appTileModel: .app(
                        .init(
                            name: "Mini Counter",
                            developerName: "Daniel Arden",
                            icon: .init()
                        )
                    ),
                    action: {}
                )
                AppTileView(appTileModel: .addNew, action: {})
            }
        }
    }
}
