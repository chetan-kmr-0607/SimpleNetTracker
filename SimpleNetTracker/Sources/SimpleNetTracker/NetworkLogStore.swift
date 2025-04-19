//
//  NetworkLogStore.swift
//  SimpleNetTracker
//
//  Created by Chetan Personal on 19/04/25.
//
import Foundation

final class NetworkLogStore: ObservableObject, @unchecked Sendable {
    static let shared = NetworkLogStore()
    @Published private(set) var logs: [TrackedRequest] = []

    func addLog(url: String, statusCode: Int?, requestBody: String?, responseBody: String?) {
        DispatchQueue.main.async {
            self.logs.append(TrackedRequest(url: url, statusCode: statusCode, requestBody: requestBody, responseBody: responseBody))
        }
    }
}
