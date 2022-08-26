//
//  CoreDataManager.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/26.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    static let functions = CoreDataManager()
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PPL")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Failed to load \(error)")
            }
        }
        return container
    }()
    
    
    // MARK: - Create Exercise
    func createItem(name: String, sets: String, reps: String, rest: String) -> Exercise? {
        let context = persistentContainer.viewContext
        let note = NSEntityDescription.insertNewObject(forEntityName: "Exercise", into: context) as! Exercise
        
        note.name = name
        note.sets = Int16(sets)!
        note.reps = Int16(reps)!
        note.rest = Int16(rest)!
        
        do {
            try context.save()
        } catch {
            print("Failed to save Item")
        }
        return nil
    }
    
    
    // MARK: - Fetch Exercise
    func fetchItem() -> [Exercise]? {
        let context      = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Exercise>(entityName: "Exercise")
        
        do {
            let exercise = try context.fetch(fetchRequest)
            return exercise
        } catch {
            print("Error fetching Items")
        }
        return nil
    }
    
    
    // MARK: - Update Exercise
    func updateItem(name: String, sets: String, reps: String, rest: String, exerciseObject: Exercise) {
        let context = persistentContainer.viewContext
        
        do {
            exerciseObject.name = name
            exerciseObject.sets = Int16(sets)!
            exerciseObject.reps = Int16(reps)!
            exerciseObject.rest = Int16(rest)!
            try context.save()
        } catch {
            print("Failed to update Item")
        }
    }
    
    
    // MARK: - Delete Exercise
    func deleteItem(exerciseObject: Exercise) {
        let context = persistentContainer.viewContext
        context.delete(exerciseObject)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete Item")
        }
    }
}
