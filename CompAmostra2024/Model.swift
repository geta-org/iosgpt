//
//  Model.swift
//  CompAmostra2024
//
//  Created by Matheus Henrique dos Santos on 19/05/24.
//

import Foundation

struct Body: Codable {
    let model: String
    let messages: [Message]
    let temperature: Double
    let max_tokens: Int
    let top_p: Int
}

struct ChatResponse: Codable {
    let id: String?
    let choices: [Choice]?
}

struct Choice: Codable {
    let index: Int?
    let message: Message?
}

struct Message: Codable, Identifiable {
    var id = UUID() //Exigido pelo protocolo Identifiable, para ser reconhecido na ListView do SwiftUI
    let role: Role
    let content: String
    
    private enum CodingKeys: String, CodingKey {
        case role
        case content
    }
}

enum Role: String, Codable {
    case user
    case system
    case assistant
}
