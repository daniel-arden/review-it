import SwiftUI

struct SeenStatusFilterPicker: View {
    @ObservedObject private var userSettings = UserSettingsService.shared

    var body: some View {
        Menu {
            ForEach(SeenStatusFilter.allCases) { seenStatusFilter in
                Button {
                    userSettings.seenStatusFilter = seenStatusFilter
                } label: {
                    HStack {
                        Text(seenStatusFilter.rawValue.capitalized)

                        Spacer()

                        if seenStatusFilter == userSettings.seenStatusFilter {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Text(userSettings.seenStatusFilter.rawValue.capitalized)
                .font(.headline)
                .foregroundColor(.accentColor)
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(.infinity)
        }

    }
}

struct SeenStatusFilterPicker_Previews: PreviewProvider {
    static var previews: some View {
        SeenStatusFilterPicker()
    }
}
