//
//  ViewController.swift
//  WhatFlower
//
//  Created by Tarek Hany on 10/3/20.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    let imagePicker = UIImagePickerController()
    let flowersBrain = FlowersBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        flowersBrain.delegate = self
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.cameraCaptureMode = .photo
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.dismiss(animated: true, completion: nil)
            flowersBrain.detect(image: img)
        }
    }
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        present(imagePicker,animated: true, completion: nil)
    }
    
}

