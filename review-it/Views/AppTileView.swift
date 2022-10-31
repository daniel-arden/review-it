import SwiftUI

struct AppTileView: View {
    private static let plusIconDimension: CGFloat = 48
    let appTileModel: AppTileModel
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Group {
                switch appTileModel {
                case .addNew:
                    addNewContent
                case let .app(appModel):
                    AppView(appModel: appModel)
                        .padding(.horizontal)
                }
            }
            .background(Color.backgroundSecondary)
            .cornerRadius(12)
        }
        .buttonStyle(BouncingButtonStyle())
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.accentColor, lineWidth: isSelected ? 2 : 0)
        )
        .padding(.vertical, 1)
    }
}

private extension AppTileView {
    var addNewContent: some View {
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
        .padding()
        .frame(maxHeight: .infinity)
    }
}
