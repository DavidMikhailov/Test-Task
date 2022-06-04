//
//  User+CoreData.swift
//  Test Balink
//
//  Created by Давид Михайлов on 03.06.2022.
//

import CoreData

// User+CoreDataClass.swift
@objc(User)
public class UserEntity: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var avatar: String?
    @NSManaged var email: String?
    @NSManaged var lastName: String?
    @NSManaged var id: NSNumber
}
