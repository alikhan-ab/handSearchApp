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
    
    var tableView: UITableView!
    let navbar = UINavigationBar(frame: CGRect(x: 0, y: 25, width: UIScreen.main.bounds.width, height: 75))
    
    var dataExample = [ExpandableSection(isExpanded: true, name: "Generalities", subsections: ["Colours", "Measurements", "Emotions","Characteristics","Numbers","General: Time"]),
                       ExpandableSection(isExpanded: true, name: "Sentences", subsections: ["Greeting & standard phrases", "Questions", "Idioms & expressions"]),
                       ExpandableSection(isExpanded: true, name: "Religion", subsections: ["Magic & myths", "Sins, negative actions & emotions", "Theological studies","Artifacts & Symbols"]),
                       ExpandableSection(isExpanded: true, name: "Pedagogy", subsections: ["Grades&Certificates", "Child care", "Education & Learning"])]
    
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
        let height: CGFloat = 75
//        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 25, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self
        let navItem = UINavigationItem()
        navItem.title = "Categories"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        navbar.items = [navItem]
        view.addSubview(navbar)
        self.view.frame = CGRect(x: 0, y: height+25, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - height-25))
    }

    @objc func back(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataExample.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        
        destination.navItem.title = dataExample[indexPath.section].subsections[indexPath.row]
//        destination.dataExample = dataExample[indexPath.section].subsections[indexPath.row]
        
        self.present(destination, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! NameCell
        let name = dataExample[indexPath.section].subsections[indexPath.row]
        cell.dayLabel.text = name
        return cell
    }
    
}
// MARK: - UISearchResultsUpdating Delegate
//extension CategoriesViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//    
//    func searchBarIsEmpty() -> Bool {
//        // Returns true if the text is empty or nil
//        return searchController.searchBar.text?.isEmpty ?? true
//    }
//    
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//        filteredFootballer = allPlayers.filter({( candy : Footballer) -> Bool in
//            return candy.name.lowercased().contains(searchText.lowercased())
//        })
//        tableview.reloadData()
//    }
//    func isFiltering() -> Bool {
//        return searchController.isActive && !searchBarIsEmpty()
//    }
//    
//}









