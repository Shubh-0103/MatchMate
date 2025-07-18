//
//  ApiServices.swift
//  MatchMate
//
//  Created by Shubh Jain on 17/07/25.
//

import Foundation

class ApiServices {
    
    private let baseURL : String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func fetchDetails(endpoint: String) async throws -> APIServiceModel? {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NSError(domain: "URL Error", code: -1, userInfo: nil)
        }
        do {
            let (data , response) = try await URLSession.shared.data(from: url)
            let jsonString = String(data: data, encoding: .utf8)
            print("Raw JSON response: \(jsonString ?? "Invalid UTF-8 data")")
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.httpError(statusCode: httpResponse.statusCode)
            }
            do{
                let decodedResponse = try JSONDecoder().decode(APIServiceModel.self, from: data)
                print( "decodedResponse \(decodedResponse) ")
                return decodedResponse
            }
            catch {
                throw APIError.decodingFailed(error)
            }
        } catch {
            print("Request failed with error: \(error)")
            throw APIError.requestFailed(error)
        }

    }
}
