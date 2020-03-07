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
import Vision

class FingerSpellingViewController: UIViewController, AVCapturePhotoCaptureDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, UIAdaptivePresentationControllerDelegate {
    
    /* Plan:
     - If Ъ/Ь 2nd line and for others
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

    var stackView = UIStackView()

    var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
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
        button.layer.borderColor = UIColor(red: 255/255, green: 247/255, blue: 214/255, alpha: 1).cgColor 
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 6
        return button
    }()

    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var videoDataOutput = AVCaptureVideoDataOutput()
    var sessionOutputSetting = AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecType.jpeg])
    
    private let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated,
                                                     attributes: [], autoreleaseFrequency: .workItem)
    
    
    
    
    private var requests = [VNRequest]()
    
    var bufferSize: CGSize = .zero
   
    var previewLayer: AVCaptureVideoPreviewLayer! = nil
    
    var sampleData = ["C", "A", "T", "B", "D", "E", "F", "G"]
    
    
    let alphabet = ["А", "Б", "В", "Г", "Д", "Е", "Ж", "З", "И/Й", "К", "Л", "М",
                    "Н", "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш/Щ",
                    "Ы", "Ь/Ъ", "Э", "Ю", "Я"]
    
    var predictions = [Int]()
    
    var buttonCount = 0
    var buttonArray = [UIButton]()
    //var isFirst = true

    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVision()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpView()
        
        var deviceInput: AVCaptureDeviceInput!
//        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInDualCamera, AVCaptureDevice.DeviceType.builtInTelephotoCamera,AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        
        let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices.first
        do {
            deviceInput = try AVCaptureDeviceInput(device: videoDevice!)
        } catch {
            print("Could not create video device input: \(error)")
            return
        }
        
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .vga640x480
        
        if (captureSession.canAddInput(deviceInput)) {
            captureSession.addInput(deviceInput)
        } else {
            print("exception!")
            captureSession.commitConfiguration()
            return
        }
        
        if captureSession.canAddOutput(videoDataOutput) {
            captureSession.addOutput(videoDataOutput)
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            print("Could not add video data output to the session")
            captureSession.commitConfiguration()
            return
        }
        
        let captureConnection = videoDataOutput.connection(with: .video)
        captureConnection?.isEnabled = true
        captureConnection?.isVideoMirrored = false
        captureConnection?.videoOrientation = .portrait
        
        do {
            try videoDevice!.lockForConfiguration()
            let dimensions = CMVideoFormatDescriptionGetDimensions((videoDevice?.activeFormat.formatDescription)!)
            bufferSize.width = CGFloat(dimensions.width)
            bufferSize.height = CGFloat(dimensions.height)
            videoDevice!.unlockForConfiguration()
        } catch {
            print(error)
        }
        captureSession.commitConfiguration()
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraView.layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = cameraView.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
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

        setupButtonsStackView()
        
        doneButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: screenSize.width/4).isActive = true
        doneButton.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -65).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 115).isActive = true
        doneButton.tag = 0
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
    }
    
    @objc func doneButtonPressed(_ sender: UIButton){
        
        let vc = FingerSpellingWordSearchVC()
        vc.letters = getLettersFromButtons()
        vc.presentationController?.delegate = self
        
        self.present(vc, animated: true) {
            self.resetButtons()
            self.predictions.removeAll()
            self.captureSession.stopRunning()
        }
    }
    
    //MARK: StackView Making methods
    func addButton(sender: UIButton) {
        buttonCount += 1

        buttonArray.insert(sender, at: sender.tag)
        
        updateStackView()
    }
    // We may need it for starting over
    func resetButtons(){
        buttonCount = 0
        buttonArray.removeAll()
        updateStackView()
    }
    
    func removeButton(sender: UIButton) {
        //if buttonCount > 1 {
            buttonCount -= 1
            buttonArray.remove(at: sender.tag)
       // }
        /*else {
            buttonCount = 0
        } */
        updateStackView()
    }
    
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
            if self.buttonArray.isEmpty {
                 button.tag = 0
                //self.isFirst = false
            } else {
                button.tag = sender.tag+1
            }
            self.addButton(sender: button)
        }))
        
        alert.addAction(UIAlertAction(title: "Edit", style: .destructive, handler: { (_) in
            print("User click Edit button")
            let letter = self.sampleData.randomElement()!
            let button = self.makeLetterButton(letter: letter)
            button.tag = sender.tag
            self.removeButton(sender: sender)
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
                
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(stackAction(tapGestureRecognizer:)))
        stackView.addGestureRecognizer(gesture1)
        stackView.isUserInteractionEnabled = true
        
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

    @objc func stackAction(tapGestureRecognizer: UITapGestureRecognizer) {
        if self.buttonArray.isEmpty {
            let alert = UIAlertController(title: "Letter adition?", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Add letter", style: .default, handler: { (_) in
                print("Adding another letter!")
                let letter = self.sampleData.randomElement()!
                let button = self.makeLetterButton(letter: letter)
                button.tag = 0
                self.addButton(sender: button)
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
                print("User click Dismiss button")
            }))
            
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
            //self.isFirst = false
        }
    }
    
//    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
//
//    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        continuePredictiong()
    }
    
    func continuePredictiong() {
        captureSession.startRunning()
    }

}

extension FingerSpellingViewController: UINavigationBarDelegate {}

extension FingerSpellingViewController {
    @discardableResult
    func setupVision() -> NSError? {
        let error: NSError! = nil
        
        do {
            let model = try VNCoreMLModel(for: fingerspelling_v1().model)
            let objectRecognitionRequest = VNCoreMLRequest(model: model) { [unowned self] (request, error) in
                
                guard let results = request.results as? [VNCoreMLFeatureValueObservation] else {
                    fatalError("Unexcpected results type")
                }
                
                DispatchQueue.main.async {
                    self.voteForSign(results)
                }
            }
            
            objectRecognitionRequest.imageCropAndScaleOption = .scaleFit
            
            requests = [objectRecognitionRequest]
        } catch let error as NSError {
            print("Model loading went wrong: \(error)")
        }
        
        return error
    }
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
//        guard let outputImage = self.getImageFromSampleBuffer(pixelBuffer: pixelBuffer) else {
//            return
//        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let cropWidth = 350
        let cropHeight = 350
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // calculate start position
        let bytesPerPixel = 4
        let startPoint = [ "x": 80, "y": 150 ]
        let startAddress = baseAddress! + startPoint["y"]! * bytesPerRow + startPoint["x"]! * bytesPerPixel

        let context = CGContext(data: startAddress, width: cropWidth, height: cropHeight, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        // now the cropped image is inside the context.
        // you can convert it back to CVPixelBuffer
        // using CVPixelBufferCreateWithBytes if you want.

        CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)

        // create image
        let cgImage: CGImage = context!.makeImage()!
        
        
        
//        let exifOrientation = exifOrientationFromDeviceOrientation()
        
//        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        let imageRequestHandler2 = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try imageRequestHandler2.perform(requests)
        } catch {
            print(error)
        }
    }
    
    
    func captureOutput(_ captureOutput: AVCaptureOutput, didDrop didDropSampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
         // print("frame dropped")
     }
    
    
    func getImageFromSampleBuffer(pixelBuffer: CVImageBuffer) ->UIImage? {
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        guard let cgImage = context.makeImage() else {
            return nil
        }
        let image = UIImage(cgImage: cgImage, scale: 1, orientation:.right)
        CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
        return image
    }
    
}

extension FingerSpellingViewController {
    func voteForSign(_ results: [VNCoreMLFeatureValueObservation]) {
        
        // Parse the CoreML's results
        guard let resultsFirst = results.first else {
            fatalError("Could not get first results from request results")
        }
        
        guard let array = resultsFirst.featureValue.multiArrayValue else {
            fatalError("No multiarray in results")
        }
        
        let length = array.count
        let doublePtr =  array.dataPointer.bindMemory(to: Double.self, capacity: length)
        let doubleBuffer = UnsafeBufferPointer(start: doublePtr, count: length)
        let output = Array(doubleBuffer)
        
        guard let maxValue = output.max(), let index = output.firstIndex(of: maxValue) else {
            fatalError("Could not find Top-1 signs")
        }
        
        predictions.append(index)
        
        if predictions.count == 35 {
            guard let (value, number) = findMostFrequentSign() else {
                fatalError("findMostFrequentSign returned nil")
            }
            
            if number > 30 {
                let button = makeLetterButton(letter: alphabet[value])
                button.tag = buttonCount
                addButton(sender: button)
                print(predictions)
                predictions.removeAll()
            } else {
                predictions.removeFirst()
            }
        }
    }
    
    func findMostFrequentSign() -> (value: Int, count: Int)? {
        let counts = predictions.reduce(into: [:]) { $0[$1, default: 0] += 1 }
        
        if let (value, count) = counts.max(by: { $0.1 < $1.1 }) {
            return (value, count)
        }
        
        return nil
    }
    
    func getLettersFromButtons() -> [String] {
        var letters = [String]()
        
        for button in buttonArray {
            guard let letter = button.currentTitle else {
                continue
            }
            letters.append(letter)
        }
        
        return letters
    }
}
