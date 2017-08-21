//
//  ReportDetailVC.swift
//  RM53
//
//  Created by Ayu on 8/14/17.
//  Copyright © 2017 com.rm53. All rights reserved.
//

import UIKit

class ReportDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var page: UIPageControl!
    let minLimit = 0
    var currentIndex = 0
    var industry = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.blue]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.title = (industry["name"] as! String)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 00/255.0, green: 24/255.0, blue: 168/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.page.currentPage = 0
        page.addTarget(self, action: #selector(updatePage), for: .touchUpInside)
        
    }
    
    func updatePage(){
        guard page.currentPage >= 0, page.currentPage <= industry.count - 1 else {return}
        if page.currentPage < industry.count && page.currentPage > currentIndex {
            currentIndex += 1
            self.collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
        }
        else if currentIndex > minLimit && page.currentPage < currentIndex {
            currentIndex -= 1
            self.collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .left, animated: true)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let current = scrollView.contentOffset.x/scrollView.frame.size.width
        page.currentPage = Int(current)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (industry["entities"] as! [Any]).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ReportCell
        let entities = industry["entities"] as! [[String:Any]]
        //cell.entityLbl.text = (entities[indexPath.row]["entity"] as! String)
        cell.keyStat.image = UIImage(named: (entities[indexPath.row]["summaryImage"] as! String))
        cell.riskSummary.image = UIImage(named: (entities[indexPath.row]["riskImage"] as! String))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }

}
