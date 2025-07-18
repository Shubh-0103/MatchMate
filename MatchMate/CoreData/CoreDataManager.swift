//
//  CoreDataManager.swift
//  MatchMate
//
//  Created by Shubh Jain on 17/07/25.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    private init() {
        persistentContainer = NSPersistentContainer(name: "MatchMate")
        persistentContainer.loadPersistentStores { _ , error in
            if let error = error {
                fatalError("CoreData loading error: \(error)")
            }
        }
    }
    func addPeople(id: String, firstName: String, lastName: String, imageURL: String, status: String, city: String, state: String , country: String){
        let context = persistentContainer.viewContext
        let people = UserEntity(context: context)
        people.userId = id
        people.firstName = firstName
        people.lastName = lastName
        people.image = imageURL
        people.status = status
        people.city = city
        people.state = state
        people.country = country
        saveContext()
    }
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }
            catch {
                print("Failed to save Core Data: \(error)")
            }
        }
    }
    func fetchUser() -> [UserEntity] {
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            return try context.fetch(request)
        }
        catch {
            print("Failed to fetch data: \(error)")
            return []
        }
    }
    func updatePeopleStatus(id: String, status: String){
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "userId == %@", id as CVarArg)
        do {
            if let user = try context.fetch(request).first {
                user.status = status
                saveContext()
            }
        }
            catch {
                print("Failed to update user status: \(error)")
            }
    }
}
