import SwiftUI
import SimpleNetTracker

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("SimpleNetTracker Demo")
                .font(.title)
                .padding()

            Button("Make API Request") {
                makeSampleRequest()
            }
        }
        .onAppear {
            SimpleNetTracker.start()
        }
    }

    private func makeSampleRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                print("Data received: \(String(decoding: data, as: UTF8.self))")
            }
            if let error = error {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
}
