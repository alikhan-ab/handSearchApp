//
//  FingerSpellingViewController.swift
//  SmartFingers
//
//  Created by DCLab on 10/1/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//
import Foundation
import UIKit
import CoreML
import AVFoundation

class FingerSpellingViewController: UIViewController, AVCapturePhotoCaptureDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /* Plan:
     - remove some unused code +
     - Merge and upload +
     - Done button add target opening table with videos
     
      finish in 1 hour! then do assignment
     
     - Change menu to 5
     -
     */
    //MARK:- Variables
    
    var navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 55))
    var navItem = UINavigationItem()
    let screenSize: CGRect = UIScreen.main.bounds

    var cameraView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var textView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var stackView = UIStackView()

    var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.backgroundColor = UIColor(red: 48/255, green: 52/255, blue: 83/255, alpha: 1)
        button.setTitleColor(UIColor(red: 255/255, green: 247/255, blue: 214/255, alpha: 1), for: .normal)
        let font = UIFont(name: "Avenir-Heavy", size: 35)
        button.titleLabel?.font = font
        button.titleLabel?.layer.shadowColor = UIColor(red: 69/255, green: 70/255, blue: 85/255, alpha: 1).cgColor
        button.titleLabel?.layer.shadowRadius = 1.0
        button.titleLabel?.layer.shadowOpacity = 7.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.titleLabel?.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.red.cgColor //UIColor(red: 69/255, green: 70/255, blue: 85/255, alpha: 1).cgColor
        button.layer.borderWidth = 15
        button.layer.cornerRadius = 6
        return button
    }()

    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var sessionOutputSetting = AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    var sampleData = ["C", "A", "T"]
    
    var buttonCount = 0
    var buttonArray = [UIButton]()
    var tempArray = [UIButton]()
    var isFirst = true

    //MARK:- Methods
    /*
     override func viewDidLoad() {
     super.viewDidLoad()
     setUpView()
     }
     */
    
    func setUpView() {
        self.view.backgroundColor = UIColor(red: 48/255, green: 52/255, blue: 83/255, alpha: 1)//UIColor(red: 69/255, green: 70/255, blue: 85/255, alpha: 1)
        navbar.delegate = self
        navItem.title = "FingerSpelling Recognition"
        //add right button item to change the camera
        navbar.items = [navItem]
        view.addSubview(navbar)
        NSLayoutConstraint.activate([
            navbar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            navbar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            navbar.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        
        [cameraView, doneButton].forEach(self.view.addSubview)
        
        cameraView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cameraView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 55).isActive = true
        cameraView.heightAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        cameraView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true

        //setupTextView()
        setupButtonsStackView()
        
        doneButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: screenSize.width/4).isActive = true
        doneButton.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -65).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 115).isActive = true
        doneButton.tag = 0
        doneButton.addTarget(self, action: #selector(letterButtonPressed), for: .touchUpInside) // for now only
    }
    
    @objc func doneButtonPressed(_ sender: UIButton){
        print("\n Done!\n")
        
    }
    
    func addButton(sender: UIButton) {
        buttonCount += 1
        buttonArray.append(sender)
        updateStackView()
    }
    
    func resetButton(sender:UIButton){
        buttonCount = 0
        buttonArray.removeAll()
        updateStackView()
    }
    
    func removeButton(sender: UIButton) {
        if buttonCount > 1 {
            buttonCount -= 1
            buttonArray.remove(at: sender.tag)
        } else {
            buttonCount = 0
        }
        updateStackView()
    }
    
    //MARK: View Making methods
    func makeLetterButton(letter: String) -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 30, width: 150, height: 150)
        button.setTitle(letter, for: .normal)
        button.backgroundColor = UIColor(red: 48/255, green: 52/255, blue: 83/255, alpha: 1)
        button.setTitleColor(UIColor(red: 255/255, green: 247/255, blue: 214/255, alpha: 1), for: .normal)
        let font = UIFont(name: "Avenir-Heavy", size: 35)
        button.titleLabel?.font = font
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.minimumScaleFactor = 0.1
        button.clipsToBounds = true
        button.titleLabel?.layer.shadowColor = UIColor(red: 69/255, green: 70/255, blue: 85/255, alpha: 1).cgColor
        button.titleLabel?.layer.shadowRadius = 1.0
        button.titleLabel?.layer.shadowOpacity = 7.0
        button.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.titleLabel?.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,action: #selector(letterButtonPressed),for: .touchUpInside)
        return button
    }
    
    @objc func letterButtonPressed(_ sender: UIButton){
        print("\n Letter! \n")
        let alert = UIAlertController(title: "Letter at \(sender.tag)", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Add letter", style: .default, handler: { (_) in
            print("Adding another letter!")
            let letter = self.sampleData.randomElement()!
            let button = self.makeLetterButton(letter: letter)
           /* if self.isFirst {
                 button.tag = 0
                self.isFirst = false
            } else {
                button.tag = sender.tag+1
            } */
            self.addButton(sender: button)
        }))
        
        alert.addAction(UIAlertAction(title: "Edit", style: .destructive, handler: { (_) in
            print("User click Edit button")
            self.removeButton(sender: sender)
            let letter = self.sampleData.randomElement()!
            let button = self.makeLetterButton(letter: letter)
           // button.tag = sender.tag
            self.addButton(sender: button)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            print("User click Delete button")
            self.removeButton(sender: sender)
        }))
                
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }

    fileprivate func setupButtonsStackView() {
        
        stackView = UIStackView(arrangedSubviews: buttonArray)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.backgroundColor = .clear
        self.view.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: cameraView.bottomAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        
    }
    
    func updateStackView(){
        //clear the stackView Array
        for aView in stackView.arrangedSubviews{
            stackView.removeArrangedSubview(aView)
            aView.removeFromSuperview()
        }
        var index = 0
        for aView in buttonArray {
            aView.tag = index
            index += 1
            stackView.addArrangedSubview(aView)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        setUpView()
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInDualCamera, AVCaptureDevice.DeviceType.builtInTelephotoCamera,AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        for device in (deviceDiscoverySession.devices) {
            if(device.position == AVCaptureDevice.Position.front){
                do{
                    let input = try AVCaptureDeviceInput(device: device)
                    if(captureSession.canAddInput(input)){
                        captureSession.addInput(input);
                        
                        if(captureSession.canAddOutput(sessionOutput)){
                            captureSession.addOutput(sessionOutput);
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
                            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill;
                            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait;
                            cameraView.layer.addSublayer(previewLayer);
                        }
                    }
                }
                catch{
                    print("exception!");
                }
            }
        }
        captureSession.startRunning()
    }
    


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = cameraView.bounds
    }
}

extension FingerSpellingViewController: UINavigationBarDelegate {}
