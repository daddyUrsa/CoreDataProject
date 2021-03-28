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
}
