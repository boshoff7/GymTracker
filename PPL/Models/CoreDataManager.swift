//
//  CoreDataManager.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/31.
//

import Foundation
import CoreData
import UIKit

struct CoreDataManager {
    static let functions = CoreDataManager()
    let context          = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveExercise() {
        do {
            try context.save()
        } catch {
        }
    }
}
