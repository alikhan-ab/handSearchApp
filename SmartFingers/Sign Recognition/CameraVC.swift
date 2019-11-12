//
//  CameraVC.swift
//  SmartFingers
//
//  Created by Aigerim on 11/8/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import UIKit
import Foundation

class CameraVC: UIViewController, UIImagePickerControllerDelegate  {
    
    var navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75))
    var navItem = UINavigationItem()
    let screenSize: CGRect = UIScreen.main.bounds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
        setupViews()
    }
    
    @objc func back(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViews(){
//        navbar.backgroundColor = UIColor.white
        navbar.delegate = self
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)
        
        //        guard let image = info[.editedImage] as? UIImage else {
        //            print("No image found")
        //            return
        //        }
        //        print(image.size)
        var image = UIImage(named: "sample")
        
    }
 
    
    
    
}

extension CameraVC: UINavigationControllerDelegate, UINavigationBarDelegate {
    
}
