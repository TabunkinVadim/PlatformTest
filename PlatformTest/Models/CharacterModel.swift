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
}



//{
//    "id": 1,
//    "name": "Rick Sanchez",
//    "status": "Alive",
//    "species": "Human",
//    "type": "",
//    "gender": "Male",

//    "origin": {
//      "name": "Earth (C-137)",
//      "url": "https://rickandmortyapi.com/api/location/1"
//    },

//    "location": {
//      "name": "Earth (Replacement Dimension)",
//      "url": "https://rickandmortyapi.com/api/location/20"
//    },

//    "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",

//    "episode": [
//      "https://rickandmortyapi.com/api/episode/1",
//      "https://rickandmortyapi.com/api/episode/2",
//      // ...
//    ],

//    "url": "https://rickandmortyapi.com/api/character/1",

//    "created": "2017-11-04T18:48:46.250Z"
//  }
