import SwiftUI

struct SimpleNetTrackerDetailView: View {
    let log: TrackedRequest

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Request URL:")
                    .font(.headline)
                Text(log.url)
                    .font(.body)
                
                Text("Request Body:")
                    .font(.headline)
                Text(log.requestBody ?? "N/A")
                    .font(.body)
                
                Text("Response Body:")
                    .font(.headline)
                Text(log.responseBody ?? "N/A")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("API Details")
    }
}
