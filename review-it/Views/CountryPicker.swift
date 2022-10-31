import SwiftUI

struct CountryPicker: View {
    @ObservedObject private var userSettings = UserSettingsService.shared
    @State private var countryListShown = false

    var body: some View {
        Button(userSettings.selectedCountryFilter.pickerLabel) {
            countryListShown.toggle()
        }
        .sheet(isPresented: $countryListShown) {
            CountryListView()
                .environmentObject(userSettings)
        }
    }
}

private final class CountryListVM: ObservableObject {
    private static let allCountryFilters = CountryFilter.allCases
    @Published var filteredCountryFilters: [CountryFilter] = CountryListVM.allCountryFilters

    @Published var searchedCountry = "" {
        didSet {
            if searchedCountry.isEmpty {
                filteredCountryFilters = Self.allCountryFilters
                return
            }

            withAnimation {
                filteredCountryFilters = Self.allCountryFilters
                    .filter { $0.pickerLabel.lowercased().contains(searchedCountry.lowercased()) }
            }
        }
    }
}

private struct CountryListView: View {
    @StateObject private var countryListVM = CountryListVM()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var userSettings: UserSettingsService

    var body: some View { content }

    @ViewBuilder
    var innerContentView: some View {
        List {
            if !userSettings.recentCountryFilters.isEmpty {
                Section("Recent") {
                    ForEach(userSettings.recentCountryFilters) { countryFilter in
                        countryFilterButton(for: countryFilter)
                    }
                }
            }

            if !countryListVM.filteredCountryFilters.isEmpty {
                Section("Countries") {
                    ForEach(countryListVM.filteredCountryFilters) { countryFilter in
                        countryFilterButton(for: countryFilter)
                    }
                }
            }
        }
    }

    func countryFilterButton(for countryFilter: CountryFilter) -> some View {
        Button(countryFilter.pickerLabel) {
            userSettings.selectedCountryFilter = countryFilter
            dismiss()
        }
        .buttonStyle(BouncingButtonStyle())
    }
}

#if os(iOS)
// MARK: - iOS Views
private extension CountryListView {
    var content: some View {
        NavigationView {
            innerContentView
                .searchable(text: $countryListVM.searchedCountry)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "multiply")
                        }

                    }
                }
                .navigationTitle("Country filter")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}
#elseif os(macOS)
// MARK: - MacOS Views
private extension CountryListView {
    var content: some View {
        VStack(spacing: 0) {
            SearchbarView(text: $countryListVM.searchedCountry)
                .padding()

            innerContentView
                .onKeyDown(.escape) { dismiss() }
                .frame(
                    minWidth: 400,
                    maxWidth: 800,
                    minHeight: 500,
                    maxHeight: 1000
                )
        }

    }
}
#endif

private extension CountryFilter {
    var pickerLabel: String {
        switch self {
        case .country(let countryModel):
            return countryModel.fullDescription
        }
    }
}

struct CountryPicker_Previews: PreviewProvider {
    static var previews: some View {
        CountryPicker()
        CountryListView()
            .environmentObject(UserSettingsService.shared)
    }
}
