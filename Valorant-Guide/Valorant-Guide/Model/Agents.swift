//
//  Agents.swift
//  Valorant-Guide
//
//  Created by Manav Deep Singh Lamba on 03/01/22.
//

import Foundation
/// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Agent
struct Agent: Codable, Identifiable{
    var uuid, displayName, welcomeDescription, developerName: String
    var id: String { uuid }
    var characterTags: JSONNull?
    var displayIcon, displayIconSmall, bustPortrait, fullPortrait: String
    var killfeedPortrait: String
    var assetPath: String
    var isFullPortraitRightFacing, isPlayableCharacter, isAvailableForTest, isBaseContent: Bool
    var role: Role
    var abilities: [Ability]
    var voiceLine: VoiceLine

    enum CodingKeys: String, CodingKey {
        case uuid, displayName
        case welcomeDescription = "description"
        case developerName, characterTags, displayIcon, displayIconSmall, bustPortrait, fullPortrait, killfeedPortrait, assetPath, isFullPortraitRightFacing, isPlayableCharacter, isAvailableForTest, isBaseContent, role, abilities, voiceLine
    }
}

// MARK: - Ability
struct Ability: Codable {
    var slot, displayName, abilityDescription: String
    var displayIcon: String

    enum CodingKeys: String, CodingKey {
        case slot, displayName
        case abilityDescription = "description"
        case displayIcon
    }
}

// MARK: - Role
struct Role: Codable {
    var uuid, displayName, roleDescription: String
    var displayIcon: String
    var assetPath: String

    enum CodingKeys: String, CodingKey {
        case uuid, displayName
        case roleDescription = "description"
        case displayIcon, assetPath
    }
}

// MARK: - VoiceLine
struct VoiceLine: Codable {
    var minDuration, maxDuration: Double
    var mediaList: [MediaList]
}

// MARK: - MediaList
struct MediaList: Codable {
    var id: Int
    var wwise: String
    var wave: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


class Api : ObservableObject{
    @Published var agents = [Agent]()
    
    func loadData(completion:@escaping ([Agent]) -> ()) {
        guard let url = URL(string: "https://valorant-api.com/v1/agents") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let books = try! JSONDecoder().decode([Agent].self, from: data!)
            print(books)
            DispatchQueue.main.async {
                completion(self.agents)
            }
        }.resume()
        
    }
}
