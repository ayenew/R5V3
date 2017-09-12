//
//  GalleryCVC.swift
//  RM53
//
//  Created by Ayu on 9/11/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
var imageArray = [String]()
class GalleryCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray = listFilesFromDocumentsFolder()!
        NotificationCenter.default.addObserver(self, selector: #selector(reloadGallery), name: NSNotification.Name.init(rawValue: "ReloadGallery"), object: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let imageName = ["imageName":imageArray[indexPath.row]]
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "ReloadImage"), object: nil, userInfo: imageName)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(imageArray.count)
        return imageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        DispatchQueue.main.async {
            let imageName = "image\(indexPath.row).png"
            print(imageName)
            let imagePath = fileIndocumentDirectory(fileName: imageName)
            cell.imView.image = self.loadImage(path: imagePath)
        }
    
        //cell.backgroundColor = UIColor.red
        return cell
    }
    
    func loadImage(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            print("no image")
        }
           return image
    }
    
    func listFilesFromDocumentsFolder() -> [String]? {
        let fileMngr = FileManager.default;
        let docs = fileMngr.urls(for: .documentDirectory, in: .userDomainMask)[0].path
        return try? fileMngr.contentsOfDirectory(atPath:docs)
    }

    func reloadGallery(_ notification: NSNotification) {
         imageArray = listFilesFromDocumentsFolder()!
         collectionView?.reloadData()
    }
}
