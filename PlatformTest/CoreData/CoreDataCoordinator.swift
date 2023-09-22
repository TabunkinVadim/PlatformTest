//
//  CoreDataCoordinator.swift
//  PlatformTest
//
//  Created by Табункин Вадим on 22.09.2023.
//

import Foundation
import CoreData

final class CoreDataCoordinator {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()

    lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext

    func seveCharacter (character: CharacterModel) {
        let saveCharacter = CharacterCoreModel(context: viewContext)
        saveCharacter.id = Int16(character.id)
        saveCharacter.name = character.name
        saveCharacter.status = character.status
        saveCharacter.species = character.species
        saveCharacter.gender = character.gender
        saveCharacter.image = character.image.jpegData(compressionQuality: 0.1)
        do {
            try viewContext.save()
        } catch let error {
            print("ERRORE: \(error)")
        }
    }

    func getCharacter (characterID: Int) -> CharacterCoreModel? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CharacterCoreModel")
        if let characters = try? viewContext.fetch(fetchRequest) as? [CharacterCoreModel], !characters.isEmpty {
            return characters[characterID]
        } else {
            return nil
        }
    }

    func getCharactersCount() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CharacterCoreModel")
        if let characters = try? viewContext.fetch(fetchRequest) as? [CharacterCoreModel], !characters.isEmpty {
            return characters.count
        } else {
            return 0
        }
    }

    public func clearAllCoreData() {
        let entities = self.persistentContainer.managedObjectModel.entities
        entities.compactMap({ $0.name }).forEach(clearDeepObjectEntity)
    }

    private func clearDeepObjectEntity(_ entity: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch {
            print ("There was an error")
        }
    }
}
