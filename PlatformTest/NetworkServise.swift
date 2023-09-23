//
//  NetworkServise.swift
//  PlatformTest
//
//  Created by Табункин Вадим on 23.09.2023.
//

import Foundation
import UIKit

class NetworkServise {

    func requestUrl(character:Int, errorAction: @escaping (Error?) -> Void,  action: @escaping (CharacterModel) -> Void) {

        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(character)" ) else { return}
        let sessions = URLSession.shared
        let task = sessions.dataTask(with: url ){data, response, error in
            guard let data = data else {

                let error = error as? NSError
                DispatchQueue.main.async {
                    errorAction(error)
                }
                return }
            do {
                var character = try JSONDecoder().decode(CharacterModel.self, from: data)
                guard let url = URL(string: character.imageURL ) else { return}
                let sessions = URLSession.shared
                let task = sessions.dataTask(with: url ){data, response, error in
                    guard let data = data else { return }
                    do {
                        let coreDataCoordinator = CoreDataCoordinator()
                        coreDataCoordinator.clearAllCoreData()
                        guard let image = UIImage(data: (data)) else {
                            return}
                        character.image = image
                        action(character)
                    }
                }
                task.resume()
            } catch let error  {
                DispatchQueue.main.async {
                    errorAction(error)
                }
            }
        }
        task.resume()
    }
}
