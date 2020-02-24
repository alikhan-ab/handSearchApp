//
//  FavouritesViewController.swift
//  SmartFingers
//
//  Created by DCLab on 14.10.2019.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavouriteViewController: UIViewController, UINavigationBarDelegate {//, KeyboardDelegate {
    
    //MARK:- Variables
    //    var allWords = [Footballer]()
    //    let searchController = UISearchController(searchResultsController: nil)
    //    var filteredFootballer = [Footballer]()
    //    var dataExample = ["A", "B", "C"]
    var dataExample = [String]()
    
    private let persistentContainer = NSPersistentContainer(name: "SmartFingers")
    lazy var fetchedResultsController: NSFetchedResultsController<Word> = {
        
        let fetchRequest: NSFetchRequest<Word> = Word.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "translation", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "favourite == 1")
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    
    var navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 55))
    var navItem = UINavigationItem()
    //    lazy var searchBar: UISearchBar = UISearchBar()
    //    let keyboardView = SignKeyboardView()
    //    var signPressed = false
    let screenSize: CGRect = UIScreen.main.bounds
    
    //    let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableview.bounds, height: <#T##CGFloat#>))
    
    //    let noDataLabel: UILabel = {
    //        let label = UILabel(frame: CGRect(x: 0, y: 0, width: table, height: <#T##CGFloat#>))
    //        label.text             = "Seems like you didn't add anything in favourites"
    //        label.textColor        = UIColor.black
    //        label.textAlignment    = .center
    //        return label
    //    }()
    //    let noDataLabel: UILabel     = UILabel(frame: CGRect(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
    //
    //    noDataLabel.text             = "Seems like you didn't add anything in favourites"
    //    noDataLabel.textColor        = UIColor.black
    //    noDataLabel.textAlignment    = .center
    //    tableView.backgroundView = noDataLabel
    //    tableView.separatorStyle = .none
    //
    
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
    
    //    @objc func signToLetter(_ sender: UIButton) {
    //        print("\n === signToLetter pressed~ === ")
    //        if !signPressed {
    //            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
    //                //Frame Option 1:
    //                self.keyboardView.frame = CGRect(x: self.keyboardView.frame.origin.x, y: self.screenSize.height - self.screenSize.width, width: self.keyboardView.frame.width, height: self.keyboardView.frame.height)
    //                //Frame Option 2:
    //                //self.myView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
    //                self.keyboardView.backgroundColor = .blue
    //
    //            }, completion: nil)
    //
    //            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
    //                //Frame Option 1:
    //                //                self.tableview.frame = CGRect(x: self.tableview.frame.origin.x, y: self.tableview.frame.origin.y, width: self.tableview.frame.width, height: self.screenSize.height-75-self.screenSize.width)
    //                self.tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.screenSize.width)
    //            }, completion: nil)
    //            signPressed = true
    //
    //
    //        } else {
    //            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
    //                //Frame Option 1:
    //                self.keyboardView.frame = CGRect(x: self.keyboardView.frame.origin.x, y: self.screenSize.height, width: self.keyboardView.frame.width, height: self.keyboardView.frame.height)
    //                //Frame Option 2:
    //                //self.myView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
    //                self.keyboardView.backgroundColor = .blue
    //
    //            }, completion: nil)
    //
    //            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
    //                //Frame Option 1:
    //                //                self.tableview.frame = CGRect(x: self.tableview.frame.origin.x, y: self.tableview.frame.origin.y, width: self.tableview.frame.width, height: self.screenSize.height-75)
    //                self.tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    //
    //            }, completion: nil)
    //
    //            signPressed = false
    //
    //
    //        }
    //    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        self.hideKeyboardWhenTappedAround()
        
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
    }
    
    func setupNavBar() {
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        navItem.leftBarButtonItem?.tintColor = UIColor(red: 255/255, green: 247/255, blue: 214/255, alpha: 1)
        if #available(iOS 13.0, *) {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithOpaqueBackground()
            coloredAppearance.backgroundColor = UIColor(r: 87, g: 69, b: 93)
            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(r: 247, g: 208, b: 111)]
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(r: 247, g: 208, b: 111)]
            
            navbar.standardAppearance = coloredAppearance
            navbar.scrollEdgeAppearance = coloredAppearance
        } else {
            // Fallback on earlier versions
        }
        //        navItem.rightBarButtonItem = UIBarButtonItem(title: "Sign", style: .plain, target: self, action: #selector(signToLetter))
        //
        //        searchBar.searchBarStyle = UISearchBar.Style.prominent
        //        searchBar.placeholder = " Search in favourites"
        //        searchBar.sizeToFit()
        //        searchBar.isTranslucent = false
        //        searchBar.backgroundImage = UIImage()
        //        searchBar.delegate = self
        //        navItem.titleView = searchBar
        
        navbar.items = [navItem]
        view.addSubview(navbar)
        
        NSLayoutConstraint.activate([
            navbar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            navbar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            navbar.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        self.view.frame = CGRect(x: 0, y: 55, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 55))
    }
    
    
    //    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
    //        //your code here....
    //        print("SEARCHIng...")
    //        filteredFootballer = allPlayers.filter { footballer in
    //            let isMatchingSearchText = footballer.name.lowercased().contains(textSearched.lowercased())// || textSearched.lowercased().count == 0
    //            //            print(isMatchingSearchText)
    //            if !isMatchingSearchText {
    //                filteredFootballer = [Footballer(name: "none", league: "")]
    //                tableview.reloadData()
    //            }
    //            return isMatchingSearchText
    //        }
    //        tableview.reloadData()
    //    }
    
    //    func didPressButton(button: LetterButton) {
    //        guard let letter = button.letter else {
    //            return
    //        }
    //        searchBar.text! += letter
    //    }
    
    func setupTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(NameCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 55),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),//, constant: -screenSize.width),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        
        //        keyboardView.delegate = self
        //        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        //        keyboardView.backgroundColor = .white
        //        view.addSubview(keyboardView)
        //        NSLayoutConstraint.activate([
        //            //             keyboardView.topAnchor.constraint(equalTo: tableview.bottomAnchor),
        //            keyboardView.topAnchor.constraint(equalTo: self.view.bottomAnchor),
        //            //             keyboardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        //            keyboardView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        //            keyboardView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        //            ])
    }
    
    
    
}
// MARK: - UISearchResultsUpdating Delegate
extension FavouriteViewController: UISearchBarDelegate {
    
}
// MARK: - UITableView Delegate
extension FavouriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if filteredFootballer.count > 0 {
        //            if filteredFootballer[0].name == "none" {
        //                return 0
        //            }
        //            return filteredFootballer.count
        //        }
        //        return allPlayers.count
        guard let words = fetchedResultsController.fetchedObjects else { return 0}
        if words.isEmpty {
            let noDataLabel = UILabel(frame: CGRect(x: self.screenSize.width/4, y: 0, width: self.tableview.bounds.width/2, height: self.tableview.bounds.height/4))
            noDataLabel.text             = "Seems like you didn't add anything here"
            noDataLabel.numberOfLines    = 3
            noDataLabel.textColor        = UIColor(r: 247, g: 208, b: 111)
            noDataLabel.textAlignment    = .center
            let font                     = UIFont(name: "Avenir-Heavy", size: 20)
            noDataLabel.font             = font
            tableView.separatorStyle     = .none
            tableView.backgroundColor    = UIColor(r: 86, g: 89, b: 122)
            
//            let image = UIImage(named: "noFoldersImage")
//            let iv = UIImageView(image: image)
//            iv.contentMode = .scaleAspectFit
//            iv.layer.frame = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 200, height: 200)
//            let tableViewBackgroundView = UIView()
//            tableViewBackgroundView.addSubview(iv)
//            self.tableView.backgroundView = tableViewBackgroundView
            
            let backImageView = UIImageView(image: UIImage(named: "list-is-empty"))
            backImageView.contentMode = .scaleAspectFit
            backImageView.layer.frame = CGRect(x: self.view.frame.midX, y: self.view.frame.midY+20, width: 80, height: 80)
            
            tableView.backgroundView = backImageView
            tableView.backgroundView?.addSubview(noDataLabel)
        }
        return words.count
        
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
        //        let name: String
        //        if filteredFootballer.isEmpty {
        //            name = allPlayers[indexPath.row].name
        //        } else {
        //            name = filteredFootballer[indexPath.row].name
        //        }
        //        destination.navItem.title = name //tableView.cellForRow(at: indexPath)?.textLabel!.text
        let word = fetchedResultsController.object(at:indexPath)
        destination.word = word
        self.present(destination, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension FavouriteViewController: NSFetchedResultsControllerDelegate {}

