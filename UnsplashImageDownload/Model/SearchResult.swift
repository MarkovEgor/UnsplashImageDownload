



import Foundation
import UIKit

struct SearchResult: Decodable {
    let total: Int
    let results: [UnsplashPhooto]
}

struct UnsplashPhooto: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue: String]
    let user: User
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct User: Decodable {

    let id: String
    let username: String
    let name: String?
    let firstName: String?
    let lastName: String?

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case firstName = "first_name"
        case lastName = "last_name"
    }
}



