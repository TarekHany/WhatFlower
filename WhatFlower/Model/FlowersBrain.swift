//
//  FlowersBrain.swift
//  WhatFlower
//
//  Created by Tarek Hany on 10/4/20.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class FlowersBrain {
    var delegate: ViewController?
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    
    func detect(image: UIImage){
            guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
                fatalError("Could not load model")
            }

        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Could not process image")
            }
            if let result = results.first {
                if result.confidence <= 0.3 {
                    self.delegate?.title = "Sorry, I am not sure!🥺"
                } else {
                    self.delegate?.title = result.identifier.capitalized
                    self.requestInfo(flowerName: result.identifier)
            }
            }
            
        }
        guard let img = image.cgImage else {
            fatalError("Could not convert UIImage to CGImage")
        }
        let handler = VNImageRequestHandler(cgImage: img)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
        
    }
    func requestInfo(flowerName: String) {
        let parameters : [String:String] = [
        "format" : "json",
        "action" : "query",
        "prop" : "extracts|pageimages",
        "exintro" : "",
        "explaintext" : "",
        "titles" : flowerName,
        "indexpageids" : "",
        "redirects" : "1",
        "pithumbsize" : "500"
        ]
        Alamofire.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                let flowerJSON: JSON = JSON(response.result.value!)
                let pageid = flowerJSON["query"]["pageids"][0].stringValue
                let flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue
                let flowerImageURL = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                self.delegate?.imageView.sd_setImage(with: URL(string: flowerImageURL))
                self.delegate?.label.text = flowerDescription
            }
        }
    }
}
