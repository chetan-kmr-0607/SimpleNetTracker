//
//  TrackedRequest.swift
//  SimpleNetTracker
//
//  Created by Chetan Personal on 19/04/25.
//

import Foundation

struct TrackedRequest: Identifiable {
    let id = UUID()
    let url: String
    let statusCode: Int?
    let requestBody: String?
    let responseBody: String?
}
