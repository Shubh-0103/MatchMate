//
//  UserModel.swift
//  MatchMate
//
//  Created by Shubh Jain on 17/07/25.
//

import Foundation

struct UserModel: Codable {
    let gender: String?
    let name: UserName?
    let location: UserLocation?
    let email: String?
    let login: UserLogin?
    let dob: UserDOB?
    let registered: UserRegistered?
    let phone: String?
    let cell: String?
    let id: UserID?
    let picture: UserPicture?
    let nat: String?
}

struct UserName: Codable {
    let title: String?
    let first: String?
    let last: String?
}

struct UserLocation: Codable {
    let street: UserStreet?
    let city: String?
    let state: String?
    let country: String?
    let postcode: CodableValue?
    let coordinates: UserCoordinates?
    let timezone: UserTimezone?
}

struct UserStreet: Codable {
    let number: Int?
    let name: String?
}

struct UserCoordinates: Codable {
    let latitude: String?
    let longitude: String?
}

struct UserTimezone: Codable {
    let offset: String?
    let description: String?
}

struct UserLogin: Codable {
    let uuid: String?
    let username: String?
    let password: String?
}

struct UserDOB: Codable {
    let date: String?
    let age: Int?
}

struct UserRegistered: Codable {
    let date: String?
    let age: Int?
}

struct UserID: Codable , Hashable {
    let name: String?
    let value: String?
}

struct UserPicture: Codable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}
enum PersonStatus: String {
    case normal = "Normal"
    case accepted = "Accepted"
    case rejected = "Rejected"
}
enum CodableValue: Codable {
    case string(String)
    case int(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let str = try? container.decode(String.self) {
            self = .string(str)
        } else if let int = try? container.decode(Int.self) {
            self = .int(int)
        } else {
            throw DecodingError.typeMismatch(CodableValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid type"))
        }
    }

    var stringValue: String {
        switch self {
        case .string(let s): return s
        case .int(let i): return String(i)
        }
    }
}
