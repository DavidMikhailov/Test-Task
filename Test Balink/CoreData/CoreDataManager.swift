//
//  CoreDataManager.swift
//  Test Balink
//
//  Created by Давид Михайлов on 02.06.2022.
//

import Foundation
import CoreData

final class CoreDataManager: DataManager {

    static let shared = CoreDataManager()
    private init() {}

    func save(model: [User]) {
        model.forEach {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: persistentContainer.viewContext) as! UserEntity
            newUser.id = NSNumber(value: $0.id)
            newUser.name = $0.firstName
            newUser.lastName = $0.lastName
            newUser.email = $0.email
            newUser.avatar = $0.avatar.map { $0.absoluteString }
        }
        saveContext()
    }

    func fetch() -> [User] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let entities = (try? persistentContainer.viewContext.fetch(fetchRequest) as? [UserEntity]) ?? []
        let users = entities.map {
            User.init(id: $0.id.intValue, firstName: $0.name ?? "", lastName: $0.lastName ?? "", avatar: $0.avatar.flatMap { URL(string: $0) }, email: $0.email ?? "")
        }
            .sorted(by: { $0.id < $1.id })
        return users
    }

    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Users")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: - Core Data Saving support
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
