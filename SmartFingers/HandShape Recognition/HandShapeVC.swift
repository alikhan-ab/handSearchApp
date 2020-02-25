//
//  HandShapeVC.swift
//  SmartFingers
//
//  Created by DCLab on 11/7/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import CoreData

class HandShapeVC: UIViewController, UINavigationBarDelegate, UINavigationControllerDelegate {
    
    //MARK:- Variables
    /*Tasks:
     - video in cell
     - add plus cell if empty collectionView
     - CoreData add
     - Change overall design:
     - remove fingerSpelling
     - change favourites icon to fingerHeart
     - change background color -> gradient
     - Animation for icons
     - position of save icon below the video
     - 
     */
    
    var navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 55))
    var navItem = UINavigationItem()
    let screenSize: CGRect = UIScreen.main.bounds
    
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(HandShapeImageCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
//    fileprivate let data = [
//        CustomData(title: "The Islands!", url: "wiki", backgroundImage: #imageLiteral(resourceName: "sample1")),
//        CustomData(title: "Sample", url: "wiki", backgroundImage: #imageLiteral(resourceName: "sample1")),
//        CustomData(title: "Sample", url: "wiki", backgroundImage: #imageLiteral(resourceName: "sample3")),
//        CustomData(title: "Sample Views!", url: "wiki", backgroundImage: #imageLiteral(resourceName: "sample1")),
//        CustomData(title: "Sample", url: "wiki", backgroundImage: #imageLiteral(resourceName: "sample1")),
//    ]
    
    var handshapes = [Shape]()
    
    var noResults = true
    
    let searchLimit = 5
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = UIColor.white
        return tv
    }()
    
    private let persistentContainer = NSPersistentContainer(name: "SmartFingers")
    lazy var fetchedResultsController: NSFetchedResultsController<Word> = {
        
        let fetchRequest: NSFetchRequest<Word> = Word.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "translation", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchRequest.fetchBatchSize = 20
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    var predicateSigns = [[Int]]()
    
    var wasLaunched = false
    
    //MARK:- Methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpViews()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !wasLaunched {
            openCameraView()
            wasLaunched = true
        }
    }
    
    @objc func back(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func changeCamera(_ sender: UIButton){
        if handshapes.count < searchLimit {
           openCameraView()
        }
    }
    
    func openCameraView(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.cameraDevice = .front
        vc.delegate = self
        present(vc, animated: true)
    }
        

    func setUpViews() {
        //NavigationBar:
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self
        navItem.title = "HandShape Recognition"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        let cameraItem = UIBarButtonItem(title: "Camera", style: .plain, target: self, action: #selector(changeCamera))
//        navItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "flip2"), style: .plain, target: self, action: #selector(changeCamera))
        //UIBarButtonItem(title: "Change camera", style: .plain, target: self, action: #selector(changeCamera))//#selector(signToLetter))
//        UIBarButtonItem(image: UIImage(named: "camera_flip"), style: .plain, target: self, action: #selector(changeCamera))
        
//        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        negativeSpacer.width = 50
//
//        navItem.rightBarButtonItems = [negativeSpacer, cameraItem]
        navItem.rightBarButtonItem = cameraItem
        navItem.leftBarButtonItem?.tintColor = UIColor(red: 255/255, green: 247/255, blue: 214/255, alpha: 1)
        navItem.rightBarButtonItem?.tintColor = UIColor(red: 255/255, green: 247/255, blue: 214/255, alpha: 1)
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
        
        //CollectionView:
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor(red: 69/255, green: 70/255, blue: 85/255, alpha: 1)//UIColor(r: 86, g: 89, b: 122)//UIColor(r: 116, g: 162, b: 214)
        self.view.backgroundColor = UIColor(red: 69/255, green: 70/255, blue: 85/255, alpha: 1)//UIColor(r: 86, g: 89, b: 122)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        
        //TableView:
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(HandShapeVideoCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(tableview)
        tableview.backgroundColor = UIColor(r: 180, g: 199, b: 231)
        tableview.separatorColor = UIColor(r: 87, g: 69, b: 93)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        
        
    }
    
    func showActionSheet(controller: UIViewController, indexPath: IndexPath) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            print("User click Delete button")


            self.handshapes.remove(at: indexPath.row)
            self.collectionView.deleteItems(at: [indexPath])
            self.newFetch()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    func newFetch() {
        var predicate: NSPredicate?
        if handshapes.count == 0 {
            predicate = nil
        } else {
            var predicates = [NSPredicate]()
            for shape in handshapes {
                guard shape.status == .accepted else { continue }
                guard let signs = shape.signs else { continue }
//                let localPredicate = NSPredicate(format: "(ANY handshapes.id == %i) OR (ANY handshapes.id == %i) OR (ANY handshapes.id == %i)", signs[0], signs[1], signs[2])
                let localPredicate = NSPredicate(format: "(ANY handshapes.id == %i) OR (ANY handshapes.id == %i)", signs[0], signs[1])
                predicates.append(localPredicate)
            }
            print("test:\(predicates.count)")
            print("test1")
            predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            print(predicate.debugDescription)
            print("test2")
        }
        
        
        fetchedResultsController.fetchRequest.predicate = predicate
        
        do {
            print("test3")
            try fetchedResultsController.performFetch()
            print("test4")
            tableview.reloadData()
            print("test5")
        } catch {
            let error = error as NSError
            print("\(error), \(error.localizedDescription)")
        }
    }
}


// MARK: - UICollectionView Delegate
extension HandShapeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/3)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return handshapes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HandShapeImageCell
        cell.data = self.handshapes[indexPath.item]
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        showActionSheet(controller: self, indexPath: indexPath)
        
    }

}

// MARK: - UITableView Delegate
extension HandShapeVC: UITableViewDataSource, UITableViewDelegate {
    
    func addNoResultsLabel() {
        let noDataLabel = UILabel(frame: CGRect(x: self.screenSize.width/4, y: 0, width: self.tableview.bounds.width/2, height: self.tableview.bounds.height))
        noDataLabel.text             = "No results"
        noDataLabel.numberOfLines    = 3
        noDataLabel.textColor        = UIColor(red: 69/255, green: 70/255, blue: 85/255, alpha: 1)//UIColor(r: 87, g: 69, b: 93)//UIColor(r: 247, g: 208, b: 111)
        noDataLabel.textAlignment    = .center
        let font                     = UIFont(name: "Avenir-Heavy", size: 40)
        noDataLabel.font             = font
        noDataLabel.tag = 100
        tableview.separatorStyle     = .none
        tableview.addSubview(noDataLabel)
        noResults = true
    }
    
    func removeNoResultsLabel() {
        noResults = false
        guard let tagView = self.view.viewWithTag(100) else { return }
        tagView.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // MARK:- To check for empty case comment the line below
        guard let words = fetchedResultsController.fetchedObjects else { return 0}
        if words.isEmpty {
            addNoResultsLabel()
        } else if noResults {
            removeNoResultsLabel()
        }
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! HandShapeVideoCell
        let word = fetchedResultsController.object(at: indexPath)
        cell.word = word
        cell.deployWord()
        cell.nameLabel.textColor = UIColor(r: 87, g: 69, b: 93)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let destination = SignWordViewController()
        let word = fetchedResultsController.object(at: indexPath)
        print(word.translation ?? "no word")
        destination.word = word
        self.present(destination, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - UIImagePickerController Delegate
extension HandShapeVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            print("error, image not returned")
            return
        }
        
        guard let imageToSend = recizeImage(image: image, percentage: 0.3) else { fatalError("Couldn't recize an image")}
        let uuid = UUID()
        
        handshapes.append(Shape(image: imageToSend, id: uuid, signs: nil, status: .loading))
        collectionView.reloadData()
        
        
        let handShapeRequest = HandShapeRequest()
        handShapeRequest.getHandShape(image: imageToSend) { [weak self] (result: [Int]?) in
            DispatchQueue.main.async {
                if let result = result {
                    print(result)
                    print(uuid.uuidString)
                    
                    if let index = self?.handshapes.firstIndex(where: { (shape) -> Bool in
                        return shape.id == uuid
                    }) {
                        self?.handshapes[index].signs = result
                        self?.handshapes[index].status = .accepted
                        self?.collectionView.reloadData()
                    }
                    
                    self?.newFetch()
                    
                } else {
                    if let presentedVC = self?.presentedViewController as? UIAlertController {
                        presentedVC.dismiss(animated: true, completion: nil)
                    }
                    
                    if let index = self?.handshapes.firstIndex(where: { (shape) -> Bool in
                        return shape.id == uuid
                    }) {
                        // Add deletion shake
                        let indexPath = IndexPath(row: index, section: 0)
                        self?.collectionView.cellForItem(at: indexPath)
                        
                        self?.handshapes.remove(at: index)
                        self?.collectionView.deleteItems(at: [indexPath])
                    }
                }
            }
        }
    }
    
    
    func recizeImage(image: UIImage, percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: image.size.width * percentage, height: image.size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: image.imageRendererFormat).image { _ in
            image.draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}

extension HandShapeVC: NSFetchedResultsControllerDelegate {}

struct Shape {
    var image: UIImage
    var id: UUID
    var signs: [Int]?
    var status: shapeStatus
    
}

enum shapeStatus {
    case loading
    case accepted
    case failed
}
