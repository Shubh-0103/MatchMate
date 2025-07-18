//
//  APIServiceModel.swift
//  MatchMate
//
//  Created by Shubh Jain on 17/07/25.
//
import Foundation

struct APIServiceModel: Codable {
    let results
    : [UserModel]?
}

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingFailed(Error)
}
