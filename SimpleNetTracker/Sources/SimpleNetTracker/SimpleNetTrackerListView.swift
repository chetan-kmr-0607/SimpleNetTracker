import SwiftUI

struct SimpleNetTrackerView: View {
    @ObservedObject private var store = NetworkLogStore.shared

    var body: some View {
        NavigationView {
            List(store.logs) { log in
                NavigationLink(destination: SimpleNetTrackerDetailView(log: log)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(log.url)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        Text("Status: \(log.statusCode.map { String($0) } ?? "Unknown")")
                            .font(.caption)
                            .foregroundColor(log.statusCode == 200 ? .green : .red)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Tracked API Calls")
        }
    }
}
