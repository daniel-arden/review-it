import SwiftUI

struct AppTileView: View {
    @Environment(\.editMode) private var editMode
    private static let plusIconDimension: CGFloat = 48

    private let appTileModel: AppTileModel
    private let isSelected: Bool
    private let isEditing: Bool
    private let action: () -> Void
    private let onDelete: () -> Void

    init(
        appTileModel: AppTileModel,
        isSelected: Bool,
        isEditing: Bool,
        action: @escaping () -> Void,
        onDelete: @escaping () -> Void = {}
    ) {
        self.appTileModel = appTileModel
        self.isSelected = isSelected
        self.isEditing = isEditing
        self.action = action
        self.onDelete = onDelete
    }

    var body: some View {
        Button(action: action) {
            Group {
                switch appTileModel {
                case .addNew:
                    addNewContent
                case let .app(appModel):
                    AppView(appModel: appModel)
                        .padding(.horizontal)
                        .if(isEditing) { view in
                            view.overlay(alignment: .topTrailing) {
                                Button(action: onDelete) {
                                    Image(systemName: "multiply")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 10, height: 10)
                                        .padding(10)
                                        .background(Color.red)
                                        .cornerRadius(12)
                                        .zIndex(5)
                                        .padding(8)
                                }
                            }
                        }
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
                .background(Color.backgroundTertiary)
                .cornerRadius(8)

            Text("Add App")
                .font(.headline)
        }
        .padding()
        .frame(maxHeight: .infinity)
    }
}
