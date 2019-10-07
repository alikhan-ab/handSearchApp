//
//  CategoriesViewController.swift
//  SmartFingers
//
//  Created by DCLab on 10/1/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct ExpandableSection {
    var isExpanded: Bool
    var name: String
    var subsections: [String]
}

class CategoriesViewController: UIViewController, UINavigationBarDelegate {
    //MARK:- Variables
    var tableView: UITableView!
    let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75))
    var navItem = UINavigationItem()
    lazy var searchBar: UISearchBar = UISearchBar()
    
    var dataExample = [ExpandableSection(isExpanded: true, name: "Generalities", subsections: ["Colours", "Measurements", "Emotions","Characteristics","Numbers","General: Time"]),
                       ExpandableSection(isExpanded: true, name: "Sentences", subsections: ["Greeting & standard phrases", "Questions", "Idioms & expressions"]),
                       ExpandableSection(isExpanded: true, name: "Religion", subsections: ["Magic & myths", "Sins, negative actions & emotions", "Theological studies","Artifacts & Symbols"]),
                       ExpandableSection(isExpanded: true, name: "Pedagogy", subsections: ["Grades&Certificates", "Child care", "Education & Learning"])]
    var coredataData = [ExpandableSection]()
    var filteredData = [ExpandableSection]()
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor.white
        loadCategroies()
        filteredData = coredataData
        setupNavBar()
        setUpTableView()
    }
    
    func loadCategroies() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let categories = try managedContext.fetch(fetchRequest)
            
            for category in categories {
                guard let categoryName = category.value(forKey: "name") as? String else {
                    fatalError("Couldn't get a category name")
                }
                
                var subcategoriesNames = [String]()
                
                let fetchSubRequest = NSFetchRequest<NSManagedObject>(entityName: "Subcategory")
                fetchSubRequest.sortDescriptors = [sortDescriptor]
                
                let predicate = NSPredicate(format: "%K = %@", "under.name", categoryName)
                fetchSubRequest.predicate = predicate
                
                do {
                    let subcategories = try managedContext.fetch(fetchSubRequest)
                    
                    for subcategory in subcategories {
                        guard let subcategoryName = subcategory.value(forKey: "name") as? String else {
                            fatalError("Couldn't get a subcategoryname")
                        }
                        subcategoriesNames.append(subcategoryName)
                    }
                    
                    coredataData.append(ExpandableSection(isExpanded: false, name: categoryName, subsections: subcategoriesNames))
                    

                } catch let error as NSError {
                    print("Could not fetch. \(error), \(error.userInfo)")
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func setUpTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        let constraints:[NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
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
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self
        let navItem = UINavigationItem()
        //        navItem.title = "Categories"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navItem.titleView = searchBar
        
        navbar.items = [navItem]
        view.addSubview(navbar)
        self.view.frame = CGRect(x: 0, y: 75, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 75))
    }
    
    @objc func back(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        filteredData = coredataData
        if !textSearched.isEmpty {
            for index in 0..<filteredData.count {
                filteredData[index].subsections = filteredData[index].subsections.filter({ item in
                    return item.lowercased().contains(textSearched.lowercased())
                })
            }
        }
        print(filteredData)
        tableView.reloadData()
    }
    
}
// MARK: - UISearchResultsUpdating Delegate
extension CategoriesViewController: UISearchBarDelegate {
}

// MARK: - UITableView Delegate
extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !filteredData[section].isExpanded {
            return 0
        }
        return filteredData[section].subsections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionView()
        view.section = section
        

        view.nameLabel.text = coredataData[section].name
        view.expandCloseButton.setTitle("Open", for: .normal)
        view.expandCloseButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        view.expandCloseButton.tag = section
        return view
    }
    
    @objc func handleExpandClose(button: UIButton) {
        
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in filteredData[section].subsections.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = filteredData[section].isExpanded
        filteredData[section].isExpanded = !isExpanded
        coredataData[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .top)
        } else {
            tableView.insertRows(at: indexPaths, with: .bottom)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = SubcategoriesViewController()
        
        let subcategoryName = filteredData[indexPath.section].subsections[indexPath.row]
        destination.subcategory = subcategoryName
        //        destination.dataExample = dataExample[indexPath.section].subsections[indexPath.row]
        self.present(destination, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! NameCell
                
        let name = filteredData[indexPath.section].subsections[indexPath.row]
        
//        let name = dataExample[indexPath.section].subsections[indexPath.row]
        cell.dayLabel.text = name
        return cell
    }
    
}
