//
//  CoreDataPerform.swift
//  CoreDataProject
//
//  Created by Alexey Golovin on 28.03.2021.
//

import UIKit
import CoreData

final class CoreDataPerform {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchPlayer() -> ([Player]) {
        do {
            return try! context.fetch(Player.fetchRequest())
        }
    }
    
    func savePlayer() {
        // Save data
        do {
            try self.context.save()
        }
        catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func deletePlayer(player: Player) {
        self.context.delete(player)
        do {
            try self.context.save()
        }
        catch {

        }
    }
    
    func filterPlayers(name: String, age: Int) -> ([Player]) {
        let request = Player.fetchRequest() as NSFetchRequest
        let namePredicate = NSPredicate(format: "%K CONTAINS %@", #keyPath(Player.fullName), name)
        let agePredicate = NSPredicate(format: "%K > %ld", #keyPath(Player.age), age)
        let nameAndAge = NSCompoundPredicate(andPredicateWithSubpredicates: [namePredicate, agePredicate])
        request.predicate = nameAndAge
        do {
            return try! context.fetch(request)
        }
    }
}
