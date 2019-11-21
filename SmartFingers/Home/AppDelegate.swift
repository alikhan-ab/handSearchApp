//
//  AppDelegate.swift
//  SmartFingers
//
//  Created by Aigerim on 9/5/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = HomeTableViewController() //ViewController
        /* Check if vocabulary is already loaded into CoreData,
         if not, load it
        */
        let defaults = UserDefaults.standard
        let isPreloaded = defaults.bool(forKey: "isPreloaded")
        if !isPreloaded {
            preloadDataModel()
            defaults.set(true, forKey: "isPreloaded")
        }
        
        return true
    }
    
    func parseVocabularyJSON() -> [CategoryJSON]? {
        guard let url = Bundle.main.url(forResource: "vocabulary", withExtension: "json"), let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        guard let categories = try? JSONDecoder().decode([CategoryJSON].self, from: data) else {
            return nil
        }
        
        return categories
    }
    
    
    func preloadDataModel() {
        guard let categories = parseVocabularyJSON() else {
            fatalError("parseJSON() returned nil")
        }
        
        deleteEnitiy("Word")
        deleteEnitiy("Subcategory")
        deleteEnitiy("Category")
        
        let managedContext = persistentContainer.viewContext
        
        for category in categories {
            let categoryObject = Category(context: managedContext)
            categoryObject.name = category.name
            
            var subcategoryObjects = [Subcategory]()
            for subcategory in category.subcategories {
                let subcategoryObject = Subcategory(context: managedContext)
                subcategoryObject.name = subcategory.name
                
                var wordObjects = [Word]()
                for word in subcategory.words {
                    let wordObject = Word(context: managedContext)
                    wordObject.id = Int16(truncatingIfNeeded: word.id)
                    wordObject.video = word.video
                    wordObject.translation = word.translation
                    wordObject.favourite = false
                    
                    wordObjects.append(wordObject)
                }
                
                subcategoryObject.contains = NSSet.init(array: wordObjects)
                subcategoryObjects.append(subcategoryObject)
            }
            
            categoryObject.over = NSSet.init(array: subcategoryObjects)

            do {
                try managedContext.save()
            } catch let error as NSError {
                fatalError("Could not save. \(error), \(error.userInfo)")
            }
            
        }
    }
    
    func deleteEnitiy(_ name: String) {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedContext.delete(objectData)
            }
        } catch let error {
            fatalError("Detele all data in \(name) error : \(error)")
        }
    }


    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SmartFingers")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
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

