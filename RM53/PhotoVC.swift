//
//  PhotoVC.swift
//  RM53
//
//  Created by Ayu on 9/11/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

func getDocumentURL()-> NSURL {
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    return documentURL as NSURL
}

func fileIndocumentDirectory(fileName: String) -> String {
    let file = getDocumentURL().appendingPathComponent(fileName)
    return file!.path
}

class PhotoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    let picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.view.backgroundColor = UIColor.white
        let lastImageIndex = imageArray.count-1
        let imageName = "image\(lastImageIndex).png"
        let imagePath = fileIndocumentDirectory(fileName: imageName)
        self.imageView.image = loadImage(path: imagePath)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadImage), name: NSNotification.Name.init(rawValue: "ReloadImage"), object: nil)
    }
    
    func reloadImage(_ notification: NSNotification) {
        if let imgName = notification.userInfo as? [String:String] {
            let name = imgName["imageName"]!
            let imagePath = fileIndocumentDirectory(fileName: name)
            self.imageView.image = loadImage(path: imagePath)
        }

    }
    
//    @IBAction func photoFromLibrary(_ sender: UIButton) {
//        picker.allowsEditing = false
//        picker.sourceType = .photoLibrary
//        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
//        picker.modalPresentationStyle = .popover
//        present(picker, animated: true, completion: nil)
//    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }


    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = chosenImage
        let lastImageIndex = imageArray.count
        let imageName = "image\(lastImageIndex).png"
        let imagePath = fileIndocumentDirectory(fileName: imageName)
        if let image = imageView.image {
            saveImage(image: image, path: imagePath)
        }else {
            
        }
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }


    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            //picker.modalPresentationStyle = .popover
            present(picker,animated: true,completion: nil)

        } else {
            noCamera()
        }
    }
    
    func saveImage(image: UIImage, path: String) {
        let imagePNG = UIImageJPEGRepresentation(image, 0.6)
        do {
            try imagePNG?.write(to: URL(fileURLWithPath: path), options: .atomic)
            print("image saved")
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "ReloadGallery"), object: nil, userInfo: nil)
        } catch {
            print("error")
        }
    }
    
    func loadImage(path: String) -> UIImage {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            print("no image")
        }
        return image!
    }
}

