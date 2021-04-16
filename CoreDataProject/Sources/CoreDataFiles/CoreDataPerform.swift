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
    
    func searchPlayers(name: String, age: String, equality: Int, position: String, team: String) -> ([Player]) {
        let request = Player.fetchRequest() as NSFetchRequest
        var predicates = [NSPredicate]()
        var equalityPosition: String {
            get {
                switch equality {
                case 0:
                    return ">="
                case 1:
                    return "="
                case 2:
                    return "<="
                default:
                    return "="
                }
            }
        }
        if name != "" {
            let namePredicate = NSPredicate(format: "%K CONTAINS %@", #keyPath(Player.fullName), name)
            predicates.append(namePredicate)
        }
        if age != "" {
            if let age = Int(age) {
                let agePredicate = NSPredicate(format: "%K \(equalityPosition) %ld", #keyPath(Player.age), age)
                predicates.append(agePredicate)
            }
        }
        if position != "" {
            let positionPredicate = NSPredicate(format: "%K LIKE %@", #keyPath(Player.position), position)
            predicates.append(positionPredicate)
        }
        if team != "" {
            let teamPredicate = NSPredicate(format: "%K LIKE %@", #keyPath(Player.club), team)
            predicates.append(teamPredicate)
        }
        let allPredicates = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        request.predicate = allPredicates
        
        do {
            return try! context.fetch(request)
        }
    }
    
    func filterPlayersInPlay(inPlay: Int) -> ([Player]) {
        let request = Player.fetchRequest() as NSFetchRequest
        var inPlayBool = false
        if inPlay == 0 {
            do {
                return try! context.fetch(request)
            }
        } else {
            switch inPlay {
            case 1:
                inPlayBool = true
            case 2:
                inPlayBool = false
            default:
                print("Out of range")
            }
            let inPlayPredicate = NSPredicate(format: "%K = %ld", #keyPath(Player.inPlay), inPlayBool)
            request.predicate = inPlayPredicate
            do {
                print(try! context.fetch(request))
                return try! context.fetch(request)
            }
        }
    }
}
