//
//  HandshapeRequest.swift
//  SmartFingers
//
//  Created by Alikhan Abutalip on 26/11/19.
//  Copyright © 2019 Aigerim Janaliyeva. All rights reserved.
//

import UIKit
class HandShapeRequest {
    let url = URL(string: "http://10.101.4.254:5000/getshape")!
    
    func getHandShape(image: UIImage, withCompletion completion: @escaping ([Int]?) -> Void) {
        
        guard let baseStr = getBase64(image: image) else {
            completion(nil)
            return
        }
        
        let jsonDict = ["image": baseStr]
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            do {
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [Int]] else {
                    completion(nil)
                    return
                }
                
                guard let shapesArray = json["shapes"] else {
                    completion(nil)
                    return
                }
                
                completion(shapesArray)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
        task.resume()
    }
    
    func getBase64(image: UIImage) -> String? {
        guard let pngImage = image.pngData() else { return nil}
        let str = pngImage.base64EncodedString(options: .lineLength76Characters)
        return str
    }
    
    
    
}
