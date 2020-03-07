//
//  FingerSpellingWordSearchVC.swift
//  SmartFingers
//
//  Created by HRI lab on 2/28/20.
//  Copyright © 2020 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import CoreData

class FingerSpellingWordSearchVC: UIViewController, UINavigationBarDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate {
    
    //MARK:- Variables

    var navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 55))
    var navItem = UINavigationItem()
    let screenSize: CGRect = UIScreen.main.bounds

 //   var noResults = true
    
    let searchLimit = 5
    
    let alphabet = ["А", "Б", "В", "Г", "Д", "Е", "Ж", "З", "И/Й", "К", "Л", "М",
                    "Н", "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш/Щ",
                    "Ы", "Ь/Ъ", "Э", "Ю", "Я"]
    
    
    var letters = [String]()
    var words = [String]()
    
    
    private let persistentContainer = NSPersistentContainer(name: "SmartFingers")
    lazy var fetchedResultsController: NSFetchedResultsController<Word> = {
        
        let fetchRequest: NSFetchRequest<Word> = Word.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "translation", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchRequest.fetchBatchSize = 20
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = UIColor.white
        return tv
    }()


    //MARK:- Methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpViews()
        
        words = calculateWordsFromLetters(letters: letters)
        print(words)
        
        persistentContainer.loadPersistentStores { (NSPersistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
            } else {
                do {
                    
                    var predicates = [NSPredicate]()
                    for word in self.words {
                        let p = NSPredicate(format: "(translation contains[cd] %@)", word)
                        predicates.append(p)
                    }
                    
                    let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
                    
                    self.fetchedResultsController.fetchRequest.predicate = predicate
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let error = error as NSError
                    print("\(error), \(error.localizedDescription)")
                }
            }
        }
    }

    
    @objc func back(_ sender: UIButton){
        self.dismiss(animated: true)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard #available(iOS 13.0, *) else { return }
        presentationController?.delegate?.presentationControllerDidDismiss?(presentationController!)
    }

    func setUpViews() {
        //NavigationBar:
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self
        navItem.title = "FingerSpelling Recognition"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))

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
        
        navbar.items = [navItem]
        view.addSubview(navbar)
        NSLayoutConstraint.activate([
            navbar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            navbar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            navbar.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        self.view.frame = CGRect(x: 0, y: 55, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 55))
        

        //TableView:
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(HandShapeVideoCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(tableview)
        tableview.backgroundColor = UIColor(r: 180, g: 199, b: 231)
        tableview.separatorColor = UIColor(r: 87, g: 69, b: 93)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 55),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        
        
    }

   
    func calculateWordsFromLetters(letters: [String]) -> [String] {
        
        let textChecker = UITextChecker()
        
        var words = [String]()
        
        for letter in letters {
            
            if letter == alphabet[8] || letter == alphabet[23] || letter == alphabet[25] {
                let letters = letter.components(separatedBy: "/")
                if words.isEmpty {
                    
                    words.append(letters[0])
                    words.append(letters[1])
                } else {
                    let wordsCount = words.count
                    for index in 0..<wordsCount {
                        words.append(words[index] + letters[1])
                        words[index] = words[index] + letters[0]
                    }
                }
            } else {
                if words.isEmpty {
                    words.append(letter)
                } else {
                    for index in 0..<words.count {
                        words[index] = words[index] + letter
                    }
                }
            }
        }
        
        for index in 0..<words.count {
            let word = words[index].lowercased()
            let misspelledRange = textChecker.rangeOfMisspelledWord(in: word, range: NSRange(0..<word.utf16.count), startingAt: 0, wrap: false, language: "ru")
            if misspelledRange.location != NSNotFound,
              let guesses = textChecker.guesses(forWordRange: misspelledRange, in: word, language: "ru") {
                print("Mispell for \(word)")
                guard let firstGuess = guesses.first else {
                    continue
                }
                print("First guess: \(firstGuess)")
                words.remove(at: index)
                words.append(contentsOf: guesses)
            }
        }
        
        return words
    }
}


// MARK: - UITableView Delegate
extension FingerSpellingWordSearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // MARK:- To check for empty case comment the line below
        guard let signs = fetchedResultsController.fetchedObjects else { return 0}
        return signs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! HandShapeVideoCell
        let word = fetchedResultsController.object(at: indexPath)
        cell.word = word
        cell.deployWord()
        
        cell.nameLabel.textColor = UIColor(r: 87, g: 69, b: 93)
        cell.nameLabel.text = word.translation
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let destination = SignWordViewController()
        let word = fetchedResultsController.object(at: indexPath)
        print(word.translation ?? "no word")
        destination.word = word
        self.present(destination, animated: true, completion: nil)
    }
    
}

