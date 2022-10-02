import SwiftUI

struct ReviewCardView: View {
    let entry: Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading) {
                    Text(entry.title.label)
                    Text("Review: \(entry.rating.label)")
                }
                .font(.headline)

                Spacer()

                VStack(alignment: .trailing) {
                    Text(entry.updated.label)
                    Text(entry.author.name.label)
                }
                .font(.body)
                .foregroundColor(.secondary)
            }

            Text(entry.content.label)
        }
        .padding()
        .background(Color.backgroundSecondary)
        .cornerRadius(12)
        .textSelection(.enabled)
    }
}

struct ReviewCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCardView(
            entry: Entry(
                author: Author(
                    name: .init(label: "Monsieur Reviewer")
                ),
                updated: .init(label: "4th of June 2022"),
                rating: .init(label: "4"),
                id: .init(label: "273894943"),
                title: .init(label: "The best app ever!"),
                content: .init(
                    label: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                )
            )
        )
    }
}
