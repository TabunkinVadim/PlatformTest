//
//  CharacterCoreModel+CoreDataProperties.swift
//  PlatformTest
//
//  Created by Табункин Вадим on 22.09.2023.
//
//

import Foundation
import CoreData


extension CharacterCoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterCoreModel> {
        return NSFetchRequest<CharacterCoreModel>(entityName: "CharacterCoreModel")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var gender: String?

}

extension CharacterCoreModel : Identifiable {

}
