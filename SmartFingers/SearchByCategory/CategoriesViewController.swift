//
//  CategoriesViewController.swift
//  SmartFingers
//
//  Created by DCLab on 10/1/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit

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
    var filteredData = [String]()
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor.white
        setupNavBar()
        setUpTableView()
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
        var subsections = [String]()
        for item in dataExample {
            for it in item.subsections {
                subsections.append(it)
            }
        }
        filteredData = subsections.filter { item in
            let isMatchingSearchText = item.lowercased().contains(textSearched.lowercased())// || textSearched.lowercased().count == 0
            return isMatchingSearchText
        }
        tableView.reloadData()
    }
    
}
// MARK: - UISearchResultsUpdating Delegate
extension CategoriesViewController: UISearchBarDelegate {
}
// MARK: - UITableView Delegate
extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataExample.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
// MARK: - PROBLEM:
    // - Shows result in every section and at that case open/close buttons doesn't work
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredData.count > 0 {
//            dataExample[section].subsections
            
//            return dataExample[section].subsections.count

            return filteredData.count
        }
        
        if !dataExample[section].isExpanded {
            return 0
        }
        return dataExample[section].subsections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionView()
        view.section = section
        

        view.nameLabel.text = dataExample[section].name
        view.expandCloseButton.setTitle("Close", for: .normal)
        view.expandCloseButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        view.expandCloseButton.tag = section
        return view
    }
    
    @objc func handleExpandClose(button: UIButton) {
        
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in dataExample[section].subsections.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = dataExample[section].isExpanded
        dataExample[section].isExpanded = !isExpanded
        
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
        
        let name: String
        if filteredData.isEmpty {
            name = dataExample[indexPath.section].subsections[indexPath.row]
        } else {
            name = filteredData[indexPath.row]
        }
        
        destination.navItem.title = name
        //        destination.dataExample = dataExample[indexPath.section].subsections[indexPath.row]
        self.present(destination, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! NameCell
        
        let name: String
        if filteredData.isEmpty {
            name = dataExample[indexPath.section].subsections[indexPath.row]
        } else {
            name = filteredData[indexPath.row]
        }
        
//        let name = dataExample[indexPath.section].subsections[indexPath.row]
        cell.dayLabel.text = name
        return cell
    }
    
}
