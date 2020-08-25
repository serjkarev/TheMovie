//
//  CoreDataService.swift
//  TneMovie
//
//  Created by skarev on 24.08.2020.
//  Copyright © 2020 skarev. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataServiceProtocol {
    func saveToDB(item: Movie?)
    func getFromDB() -> [Movie]
    func deleteFromDB(movie: Movie?)
}

class CoreDataService: CoreDataServiceProtocol {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    
    init() {
        context = appDelegate.persistentContainer.viewContext
    }
    
    func saveToDB(item: Movie?) {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy// avoid duplication in CoreData
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newMovie = NSManagedObject(entity: entity!, insertInto: context)
        newMovie.setValue(item?.title, forKey: "title")
        newMovie.setValue(item?.posterPath, forKey: "posterPath")
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getFromDB() -> [Movie] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        do {
            var retArray: [Movie] = []
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                retArray.append(Movie(title: data.value(forKey: "title") as! String,
                                      posterPath: data.value(forKey: "posterPath") as! String))
            }
            return retArray
        } catch {
            print(error.localizedDescription)
        }
        return [Movie]()
    }
    
    func deleteFromDB(movie: Movie?) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        do {
            let result = try context.fetch(request)
            for itemToDelete in result as! [NSManagedObject] {
                if (itemToDelete.value(forKey: "title") as! String) == movie?.title {
                    context.delete(itemToDelete)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

}
