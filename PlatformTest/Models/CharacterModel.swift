//
//  CharacterModel.swift
//  PlatformTest
//
//  Created by Табункин Вадим on 22.09.2023.
//

import Foundation
import UIKit

struct CharacterModel: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: [String: String]
    let location: [String: String]
    let imageURL : String
    var image: UIImage = UIImage(named: "image")!
    let episode : [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
        case url
        case created
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(String.self, forKey: .status)
        species = try container.decode(String.self, forKey: .species)
        type = try container.decode(String.self, forKey: .type)
        gender = try container.decode(String.self, forKey: .gender)
        origin = try container.decode([String:String].self, forKey: .origin)
        location = try container.decode([String:String].self, forKey: .location)
        imageURL = try container.decode(String.self, forKey: .image)
        episode = try container.decode([String].self, forKey: .episode)
        url = try container.decode(String.self, forKey: .url)
        created = try container.decode(String.self, forKey: .created)
    }

    init (from characterCoreModel : CharacterCoreModel) {
        self.id = Int(characterCoreModel.id)
        self.name = characterCoreModel.name!
        self.status = characterCoreModel.status!
        self.species = characterCoreModel.species!
        self.type = ""
        self.gender = characterCoreModel.gender!
        self.origin = [:]
        self.location = [:]
        self.imageURL = ""
        self.image = UIImage(data: characterCoreModel.image!)!
        self.episode = []
        self.url = ""
        self.created = ""

    }
}
