//
//  SessionCoreDataManager.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/29.
//

import Foundation
import CoreData

struct SessionCoreDataManager {
    
    static let functions = SessionCoreDataManager()
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PPL")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Failed to load \(error)")
            }
        }
        return container
    }()
    
    // MARK: - Create Session
    func createSession(name: String) -> Session? {
        let context = persistentContainer.viewContext
        let note    = NSEntityDescription.insertNewObject(forEntityName: "Session", into: context) as! Session
        note.name = name
        do {
            try context.save()
        } catch {
        }
        return nil
    }
    
    // MARK: - Fetch Session
    func fetchSession() -> [Session]? {
        let context      = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Session>(entityName: "Session")
        
        do {
            let session = try context.fetch(fetchRequest)
            return session
        } catch {
            print("Error fetching Items")
        }
        return nil
    }
    
    // MARK: - Update Session
    func updateSession(name: String, sets: String, reps: String, rest: String, sessionObject: Session) {
        let context = persistentContainer.viewContext
        
        do {
            sessionObject.name = name
            
            try context.save()
        } catch {
            print("Failed to update Item")
        }
    }
    
    // MARK: - Delete Session
    func deleteSession(sessionObject: Session) {
        let context = persistentContainer.viewContext
        context.delete(sessionObject)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete Item")
        }
    }
}
