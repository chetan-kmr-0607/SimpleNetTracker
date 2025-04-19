import Foundation

final class NetworkInterceptor: URLProtocol, @unchecked Sendable {
    private var sessionTask: URLSessionDataTask?
    
    override class func canInit(with request: URLRequest) -> Bool {
        // Prevent handling the same request multiple times
        if URLProtocol.property(forKey: "SimpleNetTrackerHandled", in: request) != nil {
            return false
        }
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // Clone the request to mark it as handled
        guard let newRequest = (request as NSURLRequest).mutableCopy() as? NSMutableURLRequest else {
            client?.urlProtocol(self, didFailWithError: URLError(.badURL))
            return
        }
        
        URLProtocol.setProperty(true, forKey: "SimpleNetTrackerHandled", in: newRequest)
        
        // Extract the request body if possible
        let requestBody = newRequest.httpBody.flatMap { String(data: $0, encoding: .utf8) }
        let requestURL = newRequest.url?.absoluteString ?? "Unknown"
        
        // Log the request
        print("📤 Request: \(requestURL)")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        sessionTask = session.dataTask(with: newRequest as URLRequest) { [weak self] data, response, error in
            guard let self else { return }

            DispatchQueue.main.async {
                if let response = response {
                    self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                    print("📥 Response: \(response)")
                }

                let responseBody = data.flatMap { String(data: $0, encoding: .utf8) }

                NetworkLogStore.shared.addLog(
                    url: requestURL,
                    statusCode: (response as? HTTPURLResponse)?.statusCode,
                    requestBody: requestBody,
                    responseBody: responseBody
                )

                if let data = data {
                    self.client?.urlProtocol(self, didLoad: data)
                }

                if let error = error {
                    self.client?.urlProtocol(self, didFailWithError: error)
                } else {
                    self.client?.urlProtocolDidFinishLoading(self)
                }
            }
        }
        sessionTask?.resume()
    }
    
    override func stopLoading() {
        sessionTask?.cancel()
        sessionTask = nil
    }
}
