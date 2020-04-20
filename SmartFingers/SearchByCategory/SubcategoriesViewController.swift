//
//  SubcategoriesViewController.swift
//  SmartFingers
//
//  Created by DCLab on 10/1/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SubcategoriesViewController: UIViewController, UINavigationBarDelegate {
    
    var tableView   : UITableView!
    let navbar      = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 55))
//    var dataExample = ["Colours", "Measurements", "Emotions","Characteristics","Numbers","General: Time"]
    var navItem = UINavigationItem()
    
    var subcategory: String?
    private let persistentContainer = NSPersistentContainer(name: "SmartFingers")

    lazy var fetchedResultsController: NSFetchedResultsController<Word> = {
        
        let fetchRequest: NSFetchRequest<Word> = Word.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "translation", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    let language = UserDefaults.standard.string(forKey: "language")!

    override func viewDidLoad() {
        super.viewDidLoad()
        persistentContainer.loadPersistentStores { (NSPersistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
            } else {
                do {
                    guard let subcategory = self.subcategory else {
                        fatalError()
                    }
                    self.fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "from.name = %@", subcategory)
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let error = error as NSError
                    print("\(error), \(error.localizedDescription)")
                }
            }
        }
        
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = UIColor.white
        self.setupNavBar()
        self.setUpTableView()
    }

    func setUpTableView() {
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(r: 180, g: 199, b: 231)
        let constraints:[NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        tableView.register(NameCell.self, forCellReuseIdentifier: "cellID")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupNavBar() {
        let height: CGFloat = 55
        navItem.leftBarButtonItem = UIBarButtonItem(title: kText.languages[language]?["back"] ?? "Back", style: .plain, target: self, action: #selector(back))
        navItem.leftBarButtonItem?.tintColor = UIColor(red: 255/255, green: 247/255, blue: 214/255, alpha: 1)
        if #available(iOS 13.0, *) {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithOpaqueBackground()
            coloredAppearance.backgroundColor = UIColor(r: 86, g: 89, b: 122)
            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(r: 247, g: 208, b: 111)]
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(r: 247, g: 208, b: 111)]
                   
            navbar.standardAppearance = coloredAppearance
            navbar.scrollEdgeAppearance = coloredAppearance
        } else {
            // Fallback on earlier versions
        }
        
        navbar.delegate = self
//        navItem.title =

        navbar.items = [navItem]
        navItem.title = subcategory
        view.addSubview(navbar)
        self.view.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - height))
        navItem.title = subcategory
    }

    @objc func back(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension SubcategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let words = fetchedResultsController.fetchedObjects else {return 0}
        return words.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = SignWordViewController()        
        let word = fetchedResultsController.object(at: indexPath)
        destination.word = word
        self.present(destination, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! NameCell
        let word = fetchedResultsController.object(at: indexPath)
        cell.backgroundColor = UIColor(r: 180, g: 199, b: 231)
        cell.dayLabel.textColor = UIColor(r: 87, g: 69, b: 93)
        cell.dayLabel.text = word.translation
        return cell
    }
    
}

extension SubcategoriesViewController: NSFetchedResultsControllerDelegate {}
