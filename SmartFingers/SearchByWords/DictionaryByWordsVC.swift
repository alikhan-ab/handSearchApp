//
//  DictionaryByWordsVC.swift
//  SmartFingers
//
//  Created by Aigerim on 9/16/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DictionaryByWordsVC: UIViewController, UINavigationBarDelegate, KeyboardDelegate {
    
    //MARK:- Variables
    let searchController = UISearchController(searchResultsController: nil)

    
    private let persistentContainer = NSPersistentContainer(name: "SmartFingers")
    lazy var fetchedResultsController: NSFetchedResultsController<Word> = {
        
        let fetchRequest: NSFetchRequest<Word> = Word.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "translation", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    
    
    var navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75))
    var navItem = UINavigationItem()
    lazy var searchBar: UISearchBar = UISearchBar()
    let keyboardView = SignKeyboardView()
    var signPressed = false
    let screenSize: CGRect = UIScreen.main.bounds
    
    var coredataData = [String]()
    var filteredData = [String]()
    
    var wordsList = [Word]()
    var filteredWordsList = [Word]()

    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = UIColor.white
        return tv
    }()
    
    //MARK:- Methods:
    @objc func back(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func signToLetter(_ sender: UIButton) {
        print("\n === signToLetter pressed~ === ")
        if !signPressed {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //Frame Option 1:
                self.keyboardView.frame = CGRect(x: self.keyboardView.frame.origin.x, y: self.screenSize.height - self.screenSize.width, width: self.keyboardView.frame.width, height: self.keyboardView.frame.height)
                //Frame Option 2:
                //self.myView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
                self.keyboardView.backgroundColor = .blue
                
            }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //Frame Option 1:
//                self.tableview.frame = CGRect(x: self.tableview.frame.origin.x, y: self.tableview.frame.origin.y, width: self.tableview.frame.width, height: self.screenSize.height-75-self.screenSize.width)
                self.tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.screenSize.width)
            }, completion: nil)
            signPressed = true

            
        } else {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //Frame Option 1:
                self.keyboardView.frame = CGRect(x: self.keyboardView.frame.origin.x, y: self.screenSize.height, width: self.keyboardView.frame.width, height: self.keyboardView.frame.height)
                //Frame Option 2:
                //self.myView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
                self.keyboardView.backgroundColor = .blue
                
            }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                //Frame Option 1:
//                self.tableview.frame = CGRect(x: self.tableview.frame.origin.x, y: self.tableview.frame.origin.y, width: self.tableview.frame.width, height: self.screenSize.height-75)
                self.tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

            }, completion: nil)
            
            signPressed = false
            
            
        }
    }
    
    //Load the data:
    func loadWords() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Word")
        let sortDescriptor = NSSortDescriptor(key: "translation", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let words = try managedContext.fetch(fetchRequest)
            
            for word in words {
                guard let wordName = word.value(forKey: "translation") as? String else {
                    fatalError("Couldn't get a word translation")
                }
                wordsList.append(word as! Word)
                coredataData.append(wordName)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        persistentContainer.loadPersistentStores { (NSPersistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
            } else {
                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let error = error as NSError
                    print("\(error), \(error.localizedDescription)")
                }
            }
        }
        
        
        setupNavBar()
        setupTableView()
        self.hideKeyboardWhenTappedAround()
    }
    
    func setupNavBar() {
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Sign", style: .plain, target: self, action: #selector(signToLetter))
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navItem.titleView = searchBar
        
        navbar.items = [navItem]
        view.addSubview(navbar)
        
        NSLayoutConstraint.activate([
            navbar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            navbar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            navbar.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
        self.view.frame = CGRect(x: 0, y: 75, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 75))
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        //your code here....
        print("SEARCHIng...")
    
        var predicate: NSPredicate?
        if textSearched.count > 0 {
            predicate = NSPredicate(format: "(translation contains[cd] %@)", textSearched)
        } else {
            predicate = nil
        }
        
        fetchedResultsController.fetchRequest.predicate = predicate
        
        do {
            try fetchedResultsController.performFetch()
            tableview.reloadData()
        } catch {
            let error = error as NSError
            print("\(error), \(error.localizedDescription)")
        }

    }
    
    func didPressButton(button: LetterButton) {
        guard let letter = button.letter else {
            return
        }
        searchBar.text! += letter
    }
    
    func setupTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(NameCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 75),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),//, constant: -screenSize.width),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
        
        keyboardView.delegate = self
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        keyboardView.backgroundColor = .white
        view.addSubview(keyboardView)
        NSLayoutConstraint.activate([
            //             keyboardView.topAnchor.constraint(equalTo: tableview.bottomAnchor),
            keyboardView.topAnchor.constraint(equalTo: self.view.bottomAnchor),
            //             keyboardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            keyboardView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            keyboardView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
    }
    

    
}
// MARK: - UISearchResultsUpdating Delegate
extension DictionaryByWordsVC: UISearchBarDelegate {
    
}
// MARK: - UITableView Delegate
extension DictionaryByWordsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredWordsList.count > 0 {
//            if filteredData[0] == "none" {
//                return 0
//            }
            return filteredWordsList.count
        }
        
        return wordsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 2
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! NameCell
        let word = fetchedResultsController.object(at: indexPath)
        cell.dayLabel.text = word.translation
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let destination = SignWordViewController()
        let word = fetchedResultsController.object(at:indexPath)
        destination.word = word
        self.present(destination, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
extension DictionaryByWordsVC: NSFetchedResultsControllerDelegate {}
