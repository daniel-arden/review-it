import SwiftUI

struct AppTileView: View {
    private static let plusIconDimension: CGFloat = 48
    let appTileModel: AppTileModel
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                switch appTileModel {
                case .addNew:
                    addNewContent()
                case let .app(appModel):
                    AppView(appModel: appModel)
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
                    width: Self.plusIconDimension / 2,
                    height: Self.plusIconDimension / 2
                )
                .frame(
                    width: Self.plusIconDimension,
                    height: Self.plusIconDimension
                )
                .background(Color.primary.opacity(0.1))
                .cornerRadius(8)

            Text("Add App")
                .font(.headline)
        }
    }
}
